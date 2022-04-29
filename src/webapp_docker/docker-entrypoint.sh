#!/bin/sh

conf_file="/app/nginx/conf.d/api_proxy.conf"
if [ "$NGINX_API_PROXY_ENABLED" = "true" ]; then
  nameserver="$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}')"
  [ -z "$nameserver" ] && echo "Warning: the nameserver cannot be found, something might not work as expected."
  # To work around CORS restriction, we can make nginx as a proxy for API server.
  cat <<EOF >"$conf_file"
  location /api {
    # We need to specify a DNS resolver because we use a variable to store the
    # upstream host, whose name will be resolved on demand.
    resolver $nameserver;
    set \$upstream ${NGINX_API_PROXY_URL:-https://api.example.com};
EOF
  if [ -n "$NGINX_API_PROXY_REWRITE" ]; then
  cat <<EOF >>"$conf_file"
    rewrite /api/(.*) /\$1 break;
EOF
  fi
  cat <<EOF >>"$conf_file"
    # Use variable to let nginx start even though upstream host is unavailable or down.
    proxy_pass \$upstream;
    proxy_ssl_server_name on;
    proxy_set_header X-Real-IP \$remote_addr;
  }
EOF
else
  [ -f "$conf_file" ] && rm "$conf_file"
fi

if [ "$CDN_HOST" = "CDN_HOST_STUB" ]; then
  find . -type f \( -name "*.html" -o -name "*.js" \) | while read file; do
    sed -i "s#CDN_HOST_STUB#$CDN_HOST_STUB_VALUE#g" "$file"
    # We need to regenerate the gzipped file if it exists.
    if [ -e "$file.gz" ]; then
      gzip -9 -c "$file" >"$file.gz"
    fi
  done
fi

exec nginx -g "daemon off;"

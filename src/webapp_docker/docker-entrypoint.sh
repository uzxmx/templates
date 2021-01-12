#!/bin/sh

conf_file="/app/nginx/conf.d/api_proxy.conf"
if [ "$API_PROXY_ENABLED" = "true" ]; then
  # To work around CORS restriction, we can make nginx as a proxy for API server.
  cat <<'EOF' >"$conf_file"
  location /api {
    rewrite /api/(.*) /$1 break;
    proxy_pass https://api.example.com;
    proxy_set_header X-Real-IP $remote_addr;
  }
EOF
else
  [ -f "$conf_file" ] && rm "$conf_file"
fi

exec nginx -g "daemon off;"

# vi: ft=nginx

set $cors '';
if ($http_origin ~ '^https?://(.*\.example\.com|example\.com)') {
  set $cors 'true';
}

if ($request_method = 'OPTIONS') {
  set $cors "${cors}options";
}

if ($cors = 'trueoptions') {
  add_header 'Access-Control-Allow-Origin' "$http_origin" always;
  add_header 'Access-Control-Allow-Credentials' 'true' always;
  add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, PATCH, DELETE, OPTIONS' always;
  add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Requested-With,X-Admin-Id,X-Admin-Access-Token,X-Admin-Refresh-Token,Private-Token,X-Device-Size' always;
  # required to be able to read Authorization header in frontend
  #add_header 'Access-Control-Expose-Headers' 'Authorization' always;

  # Tell client that this pre-flight info is valid for 20 days
  add_header 'Access-Control-Max-Age' 1728000 always;
  add_header 'Content-Type' 'text/plain charset=UTF-8' always;
  add_header 'Content-Length' 0 always;
  return 204;
}

if ($cors = 'true') {
  add_header 'Access-Control-Allow-Origin' "$http_origin" always;
  add_header 'Access-Control-Allow-Credentials' 'true' always;
  add_header 'Access-Control-Allow-Methods' 'GET, POST, PUT, DELETE, OPTIONS' always;
  add_header 'Access-Control-Allow-Headers' 'Accept,Authorization,Cache-Control,Content-Type,DNT,If-Modified-Since,Keep-Alive,Origin,User-Agent,X-Requested-With,X-Admin-Id,X-Admin-Access-Token,X-Admin-Refresh-Token,Private-Token' always;
  # required to be able to read Authorization header in frontend
  #add_header 'Access-Control-Expose-Headers' 'Authorization' always;
}

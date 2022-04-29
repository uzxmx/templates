## Use Nginx as an API proxy

When dealing with CORS, you may want to use nginx server as a proxy to forward
requests to the API server. To do so, you can set the environment variable
`NGINX_API_PROXY_ENABLED` and `NGINX_API_PROXY_URL` like below.

```
docker run -e NGINX_API_PROXY_ENABLED=true -e NGINX_API_PROXY_URL=https://example.com ...
```

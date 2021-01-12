## Use Nginx as an API proxy

When dealing with CORS, you may want to use nginx server as a proxy to forward
requests to the API server. To do so, you can set the environment variable
`API_PROXY_ENABLED` to `true` like below. Remember also to update the host in
[docker-entrypoint.sh](docker-entrypoint.sh).

```
docker run -e API_PROXY_ENABLED=true ...
```

## How to run

### For non-swarm mode

```
docker-compose up -d
```

### For swarm mode

```
# (Optionally) Initialize.
docker swarm init
docker network create --driver=overlay --attachable public

docker stack deploy --compose-file docker-compose.yml kibana
```

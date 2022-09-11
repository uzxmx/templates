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

docker stack deploy --compose-file docker-compose.yml nginx
```

## Get certificate

Below, we use aliyun DNS API to apply for a certificate from Let's encrypt.
The utility `acme` is from [here](https://github.com/uzxmx/dotfiles/blob/master/bin/acme).

```
export Ali_Key="YOUR_KEY"
export Ali_Secret="YOUR_SECRET"

acme issue -d dns_ali example.com "*.example.com"

# Install the certificate.
sudo mkdir -p /etc/certs && sudo chown "$(whoami):$(id -Gn | awk '{print $1}')" /etc/certs
mkdir /etc/certs/example.com
acme install example.com -t /etc/certs/example.com -r "docker restart nginx_nginx_1"
```

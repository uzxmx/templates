## Get certificate

Below, we use aliyun DNS API to apply for a certificate from Let's encrypt.

```
git clone --depth 1 https://github.com/acmesh-official/acme.sh.git
cd ./acme.sh
./acme.sh --install

export Ali_Key="YOUR_KEY"
export Ali_Secret="YOUR_SECRET"

acme.sh --issue --dns dns_ali -d "*.example.com"
```

## Install the certificate

```
sudo mkdir -p /etc/certs && sudo chown "$(whoami):$(id -Gn | awk '{print $1}')" /etc/certs
mkdir /etc/certs/example.com

acme.sh --install-cert -d "*.example.com" \
  --key-file /etc/certs/example.com/key.pem \
  --fullchain-file /etc/certs/example.com/cert.pem \
  --reloadcmd "docker restart nginx_nginx_1"
```

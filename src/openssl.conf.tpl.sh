[ req ]
distinguished_name	= req_distinguished_name
req_extensions = req_ext

[ req_ext ]
subjectAltName = @alt_names

[ alt_names ]
$(
  # The format of ALT_NAMES: example.com,foo.example.com
  if [ -n "$ALT_NAMES" ]; then
    i=1
    while read dns; do
      echo "DNS.$i = $dns"
      i="$((i + 1))"
    done < <(echo "$ALT_NAMES" | sed "s/, */\n/g")
  fi
)

[ req_distinguished_name ]
countryName			= Country Name (2 letter code)
countryName_default		= AU
countryName_min			= 2
countryName_max			= 2

stateOrProvinceName		= State or Province Name (full name)
stateOrProvinceName_default	= Some-State

localityName			= Locality Name (eg, city)

0.organizationName		= Organization Name (eg, company)
0.organizationName_default	= Internet Widgits Pty Ltd

# we can do this but it is not needed normally :-)
#1.organizationName		= Second Organization Name (eg, company)
#1.organizationName_default	= World Wide Web Pty Ltd

organizationalUnitName		= Organizational Unit Name (eg, section)
#organizationalUnitName_default	=

commonName			= Common Name (e.g. server FQDN or YOUR name)
commonName_max			= 64

emailAddress			= Email Address
emailAddress_max		= 64

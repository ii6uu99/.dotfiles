rm -rf /certs
mkdir -p certs

openssl genrsa -des3 -out certs/server.key 1024
openssl req -new -key certs/server.key -out certs/server.csr
openssl x509 -req -days 365 -in certs/server.csr -signkey certs/server.key -out certs/server.crt

#!/usr/bin/env bash
DOMAIN=$(/opt/elasticbeanstalk/bin/get-config environment -k DOMAIN)

if [ -n "$DOMAIN" ]; then
	sed -i '/server_tokens off;/a server_names_hash_bucket_size 512;' /etc/nginx/nginx.conf
	sudo certbot -n -d $DOMAIN --nginx --agree-tos --email eng.a.abdelhamid@outlook.com
else
    echo "DOMAIN does not exist or is empty."
fi
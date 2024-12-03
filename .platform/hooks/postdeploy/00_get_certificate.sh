#!/usr/bin/env bash
sed -i '/server_tokens off;/a server_names_hash_bucket_size 512;' /etc/nginx/nginx.conf
sudo certbot -n -d vrapeutic-unicef.eu-west-1.elasticbeanstalk.com --nginx --agree-tos --email eng.a.abdelhamid@outlook.com
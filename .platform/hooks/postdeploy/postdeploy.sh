#!/bin/sh

echo "Reloading system unit config..."
sudo cp /var/app/current/scripts/systemd/sidekiq.service /etc/systemd/system
sudo cp /var/app/current/scripts/rsyslog/sidekiq.conf /etc/rsyslog.d
sudo systemctl daemon-reload

echo "Enabling the Sidekiq system service..."
sudo systemctl enable sidekiq

echo "Updating the Sidekiq log config..."
sudo systemctl restart rsyslog

echo "Restarting the Sidekiq system service..."
sudo systemctl restart sidekiq
#!/bin/sh

echo "Reloading system unit config..."
sudo cp /var/app/current/scripts/systemd/sidekiq.service /etc/systemd/system
sudo systemctl daemon-reload

echo "Enabling the Sidekiq system service..."
sudo systemctl enable sidekiq

echo "Restarting the Sidekiq system service..."
sudo systemctl restart sidekiq
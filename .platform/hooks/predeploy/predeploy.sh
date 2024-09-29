#!/bin/sh

if [ -f "/etc/systemd/system/sidekiq.service" ]; then
  echo "Terminating the Sidekiq system service"
  sudo systemctl kill -s TSTP sidekiq
fi
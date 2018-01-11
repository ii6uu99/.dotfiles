#!/bin/bash
#

echo "Copying systemd service file in place"
sudo cp docker.shellinabox.service /etc/systemd/system/.

echo "Enabling the service"
sudo systemctl enable docker.shellinabox

echo "Starting the service"
sudo systemctl start docker.shellinabox

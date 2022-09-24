#!/bin/bash
echo "*** Installing apache2"
sudo apt update -y
sudo apt install apache2 -y
sudo systemctl status apache2
sudo systemctl start apache2
sudo chown -R $USER:$USER /var/www/html
sudo echo "<html><body><h1>This Web Server is UP and Running - Welcome ARTAC!</h1></body></html>" > /var/www/html/index.html
echo "*** Completed Installing apache2 and configuring index.html ***"
#! /bin/bash
sudo apt-get update -y
sudo apt-get install -y nginx
sudo systemctl start nginx
sudo systemctl enable nginx
sudo echo "<h1>this is finance application</h1>" | sudo tee /var/www/html/index.html
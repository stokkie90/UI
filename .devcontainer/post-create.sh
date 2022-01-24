#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# cd $SCRIPT_DIR/..

container install

container start &
sleep 10
kill $!

pip install -r $SCRIPT_DIR/../requirements_dev.txt

# Required to get automations to work
touch /config/automations.yaml

# pre-commit
sudo apt update; apt install -y ruby vim

pre-commit install


# Custom Cards & Modules
curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
apt-get install -y nodejs


cd /tmp
# Install dependency modules
## Browser mod
wget https://github.com/thomasloven/hass-browser_mod/archive/refs/tags/1.5.1.tar.gz -O browser_mod.tar.gz
tar -xvf browser_mod.tar.gz
rm -rf /config/custom_components/browser_mod
mv hass-browser_mod*/custom_components/browser_mod /config/custom_components/browser_mod

## virtual
wget https://github.com/twrecked/hass-virtual/archive/refs/tags/v0.7.5.tar.gz -O virtual.tar.gz
tar -xvf virtual.tar.gz
rm -rf /config/custom_components/virtual
mv hass-virtual*/custom_components/virtual /config/custom_components/virtual

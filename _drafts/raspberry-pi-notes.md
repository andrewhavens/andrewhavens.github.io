---
title: Raspberry Pi Notes
---
Cool image: http://www.raspberrypi.org/wp-content/uploads/2011/07/RaspiModelB.png

* http://www.extremetech.com/computing/148482-the-true-cost-of-a-raspberry-pi-is-more-than-you-think
* mini-USB Power adapter with at least 5v, 700mA 
* 8GB class 10 SDCard
* Can't use an apple keyboard (unpowered USB hub connected to unpowered USB hub)
* Check compatibility here: http://elinux.org/RPi_VerifiedPeripherals#USB_Wi-Fi_Adapters

Download the "Raspbian" distribution: http://www.raspberrypi.org/downloads

How to install Raspbian on an SD Card:

* 10 minutes to format with image
* https://github.com/RayViljoen/Raspberry-PI-SD-Installer-OS-X
* http://learn.adafruit.com/adafruit-raspberry-pi-lesson-1-preparing-and-sd-card-for-your-raspberry-pi/overview
* http://www.andrewmunsell.com/blog/getting-started-raspberry-pi-install-raspbian/#.UY3ZhCuG3Kw

Next:

* expand SD partition
* do other stuff like timezone, ssh
* finish and restart
* login: pi, raspberry
* sudo apt-get update
* sudo apt-get upgrade

rbenv ruby 2.0:

```bash
# install dependencies
sudo apt-get install -y git libssl-dev zlib1g-dev libreadline-dev

# install rbenv
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
echo 'eval "$(rbenv init -)"' >> ~/.profile
exec $SHELL -l

# install ruby 2.0 (takes 2.5 hours)
rbenv install 2.0.0-p195
rbenv global 2.0.0-p195

# install bundler
gem install bundler
rbenv rehash

# install gosu dependencies - https://github.com/jlnr/gosu/wiki/Getting-Started-on-Linux
sudo apt-get install build-essential freeglut3-dev libfreeimage-dev libgl1-mesa-dev \
                     libopenal-dev libpango1.0-dev libsdl-ttf2.0-dev libsndfile-dev \
                     libxinerama-dev
```

all that work and it failed to install gosu!

```bash
# forget Ruby 2.0!
sudo apt-get install ruby1.9.1-dev rubygems
sudo gem install gosu
```

it works!
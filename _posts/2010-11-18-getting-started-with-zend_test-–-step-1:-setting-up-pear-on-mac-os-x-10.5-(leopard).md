---
layout: post
title: "Getting started with Zend_Test – Step 1: Setting up PEAR on Mac OS X 10.5 (Leopard)"
date: 2010-11-18
permalink: /posts/6/getting-started-with-zend_test-–-step-1:-setting-up-pear-on-mac-os-x-10.5-(leopard)
---
**Question:** How do I get started using Zend_Test? What is the process necessary to start using Zend_Test for testing my Zend Framework application?

**Answer:** Zend_Test extends PHPUnit. Therefore, we need to start by installing PHPUnit. The easiest way to install PHPUnit is by installing PEAR. Therefore…you get the idea. We need PEAR. I’ll walk you through the process I took to install PEAR on Mac OS X 10.5 (Leopard).

Open up your trusty Terminal application by going to /Applications/Utilities.

First, we’ll switch over to a user that has enough permission to do anything, our super user:

<code>
sudo su -
</code>

Next, we’ll change directories to /usr/local by typing:

<code>
cd /usr/local
</code>

Then, we’ll download and run the pear installer:

<code>
curl http://pear.php.net/go-pear | php
</code>

Press enter to begin the installation process. Press enter again to use no HTTP proxy. You should then see a screen with seven installation locations. The first one should say /usr/local. If this is not the case, press 1 and enter. Type /usr/local and press enter again. Now we should all be on the same page.

Press enter to continue with the installation. When asked, you can accept the additional PEAR packages by typing Y and pressing enter.

The installer will run through the installation, downloading and installing the necessary packages. Eventually the installation will finish. You may receive a warning that your php.ini file does not contain the PEAR PHP directory we specified (/usr/local/PEAR). This is okay. We will be editing this file in the next step. So simply type n and press enter. Press enter againto finish the installation. PEAR should now be installed and ready to use. Let’s see if it works by typing:

<code>
pear version
</code>

We should see a few lines including the version of PEAR we just installed, PHP version, etc. But wait, we’re not done yet! We still need to edit our php.ini file. If you don’t have a php.ini, you’ll need to create one by copying the php.ini.default:

<code>
cp /etc/php.ini.default /etc/php.ini
</code>

Now were ready to edit our php.ini file. Open the file with Pico (or any other text editor):

<code>
pico /etc/php.ini
</code>

Scroll down about 1/3 and find the line that says:

<code>
;include_path = “.:/php/includes”
</code>

The semicolon at the beginning of the line means it’s commented out. Replace this line with the following:

<code>
include_path = “.:/usr/local/PEAR”
</code>


Press Control + O, then enter, to save your changes. Then, Control + X to exit Pico. Restart your Apache server and you should be good to go!

<code>
apachectl restart
</code>

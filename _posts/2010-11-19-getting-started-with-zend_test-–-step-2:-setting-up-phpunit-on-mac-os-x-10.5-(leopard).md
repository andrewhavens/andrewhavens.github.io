---
layout: post
title: "Getting started with Zend_Test – Step 2: Setting up PHPUnit on Mac OS X 10.5 (Leopard)"
date: 2010-11-19
permalink: /posts/7/getting-started-with-zend_test-–-step-2:-setting-up-phpunit-on-mac-os-x-10.5-(leopard)
---
**Question:** How do I get started using Zend_Test? What is the process necessary to start using Zend_Test for testing my Zend Framework application?

**Answer:** Zend_Test extends PHPUnit. Therefore, we need to start by installing PHPUnit. The easiest way to install PHPUnit is by installing PEAR. If you’ve compled step one in this series, you’re all set! If you don’t already have PEAR set up, you should go back and read Step one: setting up PEAR. You will soon see why PEAR makes PHPUnit so easy to install.

So now that we have PEAR all ready to go, all we have to do is add the PHPUnit channel to PEAR’s known channels. But first, let’s start by switching to the super user, so we don’t have to keep entering our password.

<code>
sudo su -
</code>

Next, we tell PEAR to discover the PHPUnit channel:

<code>
sudo pear channel-discover pear.phpunit.de
</code>

Now all we have to do is tell pear to install PHPUnit, and we’re done!

<code>
pear install phpunit/PHPUnit
</code>

---
layout: post
title: "Setting up logging with Firebug and FirePHP in Zend Framework 1.7.5"
date: 2010-11-18
permalink: /posts/1/setting-up-logging-with-firebug-and-firephp-in-zend-framework-1.7.5
---
**Question:** How do I set up logging with FirePHP in Zend Framework?

**Answer:**

* Step 1: Make sure you have Zend Framework 1.6+
* Step 2: Install both Firebug and FirePHP extensions for Firefox.
* Step 3: Make sure you have Console and Net enabled.
* Step 4: Set up Zend Log in your bootstrap file:

<code lang="php">
$writer = new Zend_Log_Writer_Firebug();
$logger = new Zend_Log($writer);
</code>

You can now send a log message to Firebug with the following code (in your bootstrap file):

<code lang="php">
$logger->log('Hello World!', Zend_Log::DEBUG);
</code>

If you wanted to use the logger outside of your bootstrap file, you can set $logger in the session:

<code lang="php">
Zend_Registry::set('logger', $logger);

$logger = Zend_Registry::get('logger');
$logger->log('This is my log message', Zend_Log::INFO);
</code>

However, when I want to debug, I don’t want a bunch of lines or characters when I just want to output something to the logger. So I prefer to make a function in my bootstrap file that can be used throughout my application:

<code lang="php">
$writer = new Zend_Log_Writer_Firebug();
$logger = new Zend_Log($writer);
Zend_Registry::set('logger', $logger);

function debug($message) {
$logger = Zend_Registry::get('logger');
$logger->debug($message);
}
</code>

That way, in my I can use by simply calling:

<code lang="php">
debug('hello!');
</code>

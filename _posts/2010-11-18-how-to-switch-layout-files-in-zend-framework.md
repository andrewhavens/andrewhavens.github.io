---
layout: post
title: "How to switch layout files in Zend Framework"
date: 2010-11-18
permalink: /posts/4/how-to-switch-layout-files-in-zend-framework
---
I can never remember how to do this, so I'm posting it here for future reference.

This is how you can switch layout files in Zend Framework:

```text
// Within controller
$this->_helper->_layout->setLayout('other-layout') //other-layout.phtml

//Within view script
<?php $this->layout()->setLayout('other-layout'); ?>
```

---
layout: post
title: "AJAX file upload with Zend Framework and jQuery"
date: 2010-11-18
permalink: /posts/3/ajax-file-upload-with-zend-framework-and-jquery
---
I’m in the process of trying to create a Zend Framework plugin, or helper that will add AJAX file upload capabilities to a Zend Form. It needs to degrade gracefully so that a user can still upload a file in case they have JavaScript (or Flash) disabled in their browser.

Here’s some plugins I’ve found along the way that might help you:

* [PHP Letter: AJAX File Upload jQuery Plugin](http://www.phpletter.com/Our-Projects/AjaxFileUpload/)
* [Andrew Valums: AJAX Upload](http://valums.com/ajax-upload/)
* [jQuery Form Plugin](http://jquery.malsup.com/form/) (includes AJAX file upload)
* [Uploadify: multiple file upload plugin for jQuery](http://www.uploadify.com/)
* [Fancy Upload: MooTools AJAX file upload](http://digitarald.de/project/fancyupload/)
* [SWFUpload: JavaScript Flash AJAX file upload](http://swfupload.org/) (degrades gracefully to normal HTML upload form)

If you have any experience (or success) with this, please share it in the comments.

I’ll post the solution when I am done.

---
layout: post
title: "How to set up the Zend Framework Command Line Tool on Mac OS X"
date: 2010-11-18
permalink: /posts/5/how-to-set-up-the-zend-framework-command-line-tool-on-mac-os-x
---
Now that the Zend Framework ships with a command line tool, it’s even easier to get started using the Zend Framework. In this tutorial, I will show you how to set up the command line tool for use on Mac OS X.

First, [download the newest version of the Zend Framework](http://framework.zend.com/download/latest). Both the full and minimal versions come with the Command Line tool. For this tutorial, I will be using version 1.9.3.

Once the folder has downloaded, it will need to be extracted and moved somewhere you can find it. I will be moving this folder to the top level “/Library/” directory so it will be easy to type. Within the ZendFramework directory, there is a directory called bin. Within this directory is a file called zf.sh. This is the command line tool. So if you want to use the tool, open the Terminal application and navigate to the directory that you want your project created.

<code>
cd Sites
</code>

Then, type:

<code>
/Library/ZendFramework/bin/zf.sh create project InsertProjectNameHere
</code>

A new Zend Framework project will be created in the Sites directory with the name of InsertProjectNameHere. But this is more than I’d rather type on a regular basis, so we should create an alias. To create an alias, type the following:

<code>
alias zf=/Library/ZendFramework/bin/zf.sh
</code>

Now all we have to type is:

<code>
zf create project MyApp
</code>

That’s it! By running this command in the command line, we have just created a new Zend Framework project in the current directory.

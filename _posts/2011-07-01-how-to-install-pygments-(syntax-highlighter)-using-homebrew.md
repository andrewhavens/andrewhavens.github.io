---
layout: post
title: "How to install Pygments (syntax highlighter) using Homebrew"
date: 2011-07-01
permalink: /posts/13/how-to-install-pygments-(syntax-highlighter)-using-homebrew
---
Recently, I found a Ruby Gem that I wanted to install and try out, but found out that [Pygments][1] was a dependency that I need to install first. I immediately tried to see if I could install it with [Homebrew (the best package manager ever, for the Mac)][2]...

    brew install pygments   #wont work

There is no Homebrew formula available to install it. After some searching, I found out that Pygments is one of Homebrew's formulas it won't accept. "Why can't I install Pygments using Homebrew?" I wondered. The reason is because Pygments is written in Python, and Python has its own package manager. This is sort of like how Ruby has RubyGems or PHP has, *shudder*, PEAR.

Your Mac already came with Python installed, so you already have everything you need in order to install Pygments. 

    sudo easy_install Pygments

If you're wondering, [`easy_install`][3] is a Python module used for managing Python packages.

[1]: http://pygments.org/
[2]: http://mxcl.github.com/homebrew/
[3]: http://packages.python.org/distribute/easy_install.html

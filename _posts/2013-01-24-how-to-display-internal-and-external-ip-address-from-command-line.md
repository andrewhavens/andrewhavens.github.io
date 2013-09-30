---
layout: post
title: "How to display internal and external IP address from command line"
date: 2013-01-24
permalink: /posts/26/how-to-display-internal-and-external-ip-address-from-command-line
---
I find myself needing to find my local and external IP addresses rather often, so I created a few command line helpers to do this for me. Just add this to your `~/.bash_profile`:

```bash
function externalip () { curl http://ipecho.net/plain; echo; }
function internalip { /sbin/ifconfig | grep inet | awk '{ if ( $1 == "inet" ) { print $2 } else if ( $2 == "Link" ) { printf "%s:" ,$1 } }' | grep -v 127.0.0.1; }
```

Now you can find your internal and external IP addresses from the command line by typing `externalip` or `internalip`.

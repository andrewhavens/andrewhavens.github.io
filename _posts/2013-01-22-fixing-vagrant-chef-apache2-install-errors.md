---
layout: post
title: "Fixing Vagrant Chef Apache2 install errors"
date: 2013-01-22
permalink: /posts/25/fixing-vagrant-chef-apache2-install-errors
---
Are you getting an error that looks like this?

```text
[2013-01-21T19:24:34+01:00] INFO: Processing package[apache2] action install (apache2::default line 20)

================================================================================
Error executing action `install` on resource 'package[apache2]'
================================================================================

Chef::Exceptions::Exec
----------------------
apt-get -q -y install apache2=2.2.14-5ubuntu8.9 returned 100, expected 0

Resource Declaration:
---------------------
# In /tmp/vagrant-chef-1/chef-solo-1/cookbooks/apache2/recipes/default.rb

 19: 
 20: package "apache2" do
 21:   package_name node['apache']['package']
 22: end
 23: 
```
Make sure you include the [apt recipe](https://github.com/opscode-cookbooks/apt) before this. It performs an apt-get update which will fix this problem.

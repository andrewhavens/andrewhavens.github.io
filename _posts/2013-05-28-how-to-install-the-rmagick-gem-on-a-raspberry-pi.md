---
layout: post
title: "How to install the RMagick gem on a Raspberry Pi"
date: 2013-05-28
permalink: /posts/29/how-to-install-the-rmagick-gem-on-a-raspberry-pi
---
If you're running into errors like `can't find magick-config` or `can't find MagickWand.h` then you are probably missing some development dependencies. Assuming you already have Ruby installed...

```bash
$ sudo apt-get install libmagickcore-dev libmagickwand-dev
$ gem install rmagick
```


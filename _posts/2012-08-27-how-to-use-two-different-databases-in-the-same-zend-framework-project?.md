---
layout: post
title: "How to use two different databases in the same Zend Framework project?"
date: 2012-08-27
permalink: /posts/17/how-to-use-two-different-databases-in-the-same-zend-framework-project?
---
Sometimes you need to use two different databases in a single project. Using two databases in a single Zend Framework project should be a pretty simple and straight-forward thing. However, this turned out to be a bit of a wild goose chase in order to figure out the Zend Framework specific syntax.

## Same host, different database name

If you only need to change the name of the database you connect to, you can specify that when you define your `Table` object. You can keep your default database connection the same as below:

```ini
resources.db.adapter = PDO_MYSQL
resources.db.params.dbname = database1
resources.db.params.username = dbtest
resources.db.params.password = ******
resources.db.params.hostname = localhost
resources.db.isDefaultTableAdapter = true
```

Now in your `Zend_Db_Table` class you can specify which database you want to use:

```php
<?php

class Customer extends Zend_Db_Table_Abstract
{
    protected $_name   = 'customers';
    protected $_schema = 'database1'; //not necessary because we made this the default
}

class Product extends Zend_Db_Table_Abstract
{
    protected $_name   = 'products';
    protected $_schema = 'database2';
}
```

If you have a different situation than this, you might find [this tutorial](http://www.amazium.com/blog/using-different-databases-with-zend-framework) helpful.

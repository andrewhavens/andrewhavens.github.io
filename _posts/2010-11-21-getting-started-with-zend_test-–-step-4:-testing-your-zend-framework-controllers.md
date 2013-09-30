---
layout: post
title: "Getting started with Zend_Test – Step 4: Testing your Zend Framework Controllers"
date: 2010-11-21
permalink: /posts/9/getting-started-with-zend_test-–-step-4:-testing-your-zend-framework-controllers
---
Finally! We can start testing our Controllers! I will assume that your application has the same directory structure as the Zend Framework Quick Start tutorial. Here’s an overview of what our directory structure will look like:

```sh
/myApp/application/controllers
/myApp/tests/application/controllers
```

Our tests directory will mirror our application. We might also include a ‘library’ directory in the tests directory so we can test our custom library components. For now, we’ll just keep it simple and test our controllers.

Now, we’ll create a file that will take care of auto loading. Create a new file called ‘loader.php’ in you tests directory. All of our tests will require this file.

```php
<?php
 
define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application/'));
 
set_include_path( APPLICATION_PATH . '/../library' . PATH_SEPARATOR .
APPLICATION_PATH . '/models' . PATH_SEPARATOR .
APPLICATION_PATH . '/forms' . PATH_SEPARATOR .
get_include_path() );
 
require_once "Zend/Loader.php";
Zend_Loader::registerAutoload();
```

Now let’s create a simple controller test. We’ll call this `IndexControllerTest.php` and put it in our tests/application/controllers directory. We just need to set the location of our bootstrap file. When `Zend_Test_PHPUnit_ControllerTestCase` is constructed, it will look for the bootstrap file that we set here.

```php
<?php
 
require_once '../loader.php';
 
class IndexControllerTest extends Zend_Test_PHPUnit_ControllerTestCase
{
    public $bootstrap = '../../application/bootstrap.php';
 
    public function testIndexAction()
    {
        $this->dispatch('/index');
        $this->assertController('index');
        $this->assertAction('index');
        $this->assertResponseCode(200);
    }
 
}
```

That’s it! All we have to do is run this file with our PHPUnit command line interface (that we used in the last tutorial).

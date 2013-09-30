---
layout: post
title: "Getting started with Zend_Test – Step 3: Make sure PHPUnit is ready for testing"
date: 2010-11-20
permalink: /posts/8/getting-started-with-zend_test-step-3-make-sure-phpunit-is-ready-for-testing
---
Now that we’ve installed PEAR and PHPUnit, we can verify that PHPUnit is working correctly by writing our first test.

Since we installed PHPUnit through PEAR, and we have properly configured our include_path variable in our php.ini file, we can create our test files anywhere and PHP will know where to look to find PHPUnit. So I will create a new file in my /Users/andrew/Sites directory and call it FoobarTest.php with the following contents:

<code lang="php">
<?php

class FoobarTest extends PHPUnit_Framework_TestCase {

    public function testFoobar() {
        $this->fail();
    }
}
</code>

By writing our function name to start with “test”, PHPUnit will know to run this function as a test. Typically you will want to name your test functions with names similar to the functions that you are testing, preceded by “test”.

Now let’s run our test!

<code>
cd /Users/andrew/Sites
phpunit FoobarTest.php
</code>

You should see something like the following:

<code>
PHPUnit 3.3.15 by Sebastian Bergmann.

F

Time: 0 seconds

There was 1 failure:

1) testFoobar(FoobarTest)
/Users/andrew/Sites/FoobarTest.php:6

FAILURES!
Tests: 1, Assertions: 0, Failures: 1.
</code>

Yay! It works! “But wait,” you say, “it says failures. Why is this a good thing?” Test-driven development is all about writing tests first. Remember this saying: Red, Green, Refactor. Start by writing the test, which will fail, of course, because you haven’t written any code yet! Then write the code until your test passes. Then STOP. There’s no need to keep writing. The code is finished. You know it works because you have the test to prove it. Tests are written to fail. Code is written to fix the tests.

However, this is a poor example of a test, so let’s write a real one.

Let’s start by thinking about what we want to build. How about we build a class called Foobar (to make things easy since we already have a FoobarTest) that has a function called getMessage(). However, getMessage() doesn’t return a string like we might expect, it returns an array. A test for that might look like the following. Also note that our function name is a little more verbose. Tests can serve as a sort of documentation. Think of underscores as commas and name your functions to explain what happens in the test.

<code lang="php">
<?php

class FoobarTest extends PHPUnit_Framework_TestCase {

public function testGetMessage_ReturnsAnArray() {
$foobar = new Foobar();
$message = $foobar->getMessage();
$this->assertTrue(is_array($message));
}

}
</code>

Now if we run our test again, we should see the following:

<code>
PHPUnit 3.3.15 by Sebastian Bergmann.

PHP Fatal error:  Class 'Foobar' not found in /Users/andrew/Sites/FoobarTest.php on line 6

Fatal error: Class 'Foobar' not found in /Users/andrew/Sites/FoobarTest.php on line 6
</code>

Now we have an error that says PHPUnit can’t find our Foobar class. Well that’s because we haven’t created it yet! So create a new file in the same directory as our test, name it Foobar.php, and give it the following contents:

<code lang="php">
<?php

class Foobar {

}
</code>

Next, let’s update our test so it knows where to find our new class:

<code lang="php">
<?php

require_once('Foobar.php');

class FoobarTest extends PHPUnit_Framework_TestCase {

//...
</code>

That’s all we need to do. Remember, all we are trying to do is get the test to pass. Right now the test tells us that we need to create a Foobar class so that’s what we’ve done. Let’s run our test again and see what it says.

<code>
PHPUnit 3.3.15 by Sebastian Bergmann.

PHP Fatal error:  Call to undefined method Foobar::getMessage() in /Users/andrew/Sites/FoobarTest.php on line 9

Fatal error: Call to undefined method Foobar::getMessage() in /Users/andrew/Sites/FoobarTest.php on line 9
</code>

Hooray! We no longer have the same message as before. Now we need to create our getMessage() function in our Foobar class.

<code lang="php">
<?php

class Foobar {

public function getMessage() {

}

}
</code>

Run our test again and we should see another change:

<code>
PHPUnit 3.3.15 by Sebastian Bergmann.

F

Time: 0 seconds

There was 1 failure:

1) testGetMessage_ReturnsAnArray(FoobarTest)
Failed asserting that <boolean:false> is true.
/Users/andrew/Sites/FoobarTest.php:10

FAILURES!
Tests: 1, Assertions: 1, Failures: 1.
</code>

getMessage() doesn’t return anything, so let’s change that:

<code lang="php">
<?php

class Foobar {

public function getMessage() {
return array();
}

}
</code>

That should be enough for us to get our test to pass. Let’s see if it works.

<code>
PHPUnit 3.3.15 by Sebastian Bergmann.

.

Time: 0 seconds

OK (1 test, 1 assertion)
</code>

It works! We’re done. I think you get the picture. Let’s move on to some actual controller tests.

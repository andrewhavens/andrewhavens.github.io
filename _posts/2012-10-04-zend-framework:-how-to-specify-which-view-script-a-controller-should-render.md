---
layout: post
title: "Zend Framework: How to specify which view script a controller should render"
date: 2012-10-04
permalink: /posts/22/zend-framework-how-to-specify-which-view-script-a-controller-should-render
---
Need to render a different view script than the default? There are actually a few different ways to do it, depending on the situation. Given the following controller:

```php
<?php

class MyController extends Zend_Controller_Action
{
    public function existingAction()
    {
        $this->view->foo = 'original';
    }

    public function reuseExistingViewAction()
    {
        $this->view->foo = 'bar';
    }
}
```

The options we have available are:

 - `$this->render('existing')`
 - `$this->renderScript('my-controller/existing.phtml')`
 - `$this->_helper->viewRenderer->setRender('existing');`
 - `$this->_helper->viewRenderer('existing');` (calls the `setRender` method internally)

However, each method acts differently. Let's see how they differ.

### Using the controller's `render()` method:

```php
public function reuseExistingViewAction()
{
    $this->render('existing'); // renders immediately, so only useful if it's at the end of the function
    $this->view->foo = 'bar'; // this code is never added to the view ...
}
```

### Using the `ViewRenderer` helper:

```php
public function reuseExistingViewAction()
{
    $this->_helper->viewRenderer('existing'); // allows us to set early
    $this->view->foo = 'bar'; // works as expected
}
```

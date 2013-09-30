---
layout: post
title: "How to create a REST API for your PHP application using Ruby"
date: 2012-08-28
permalink: /posts/18/how-to-create-a-rest-api-for-your-php-application-using-ruby
---
Sometimes you are in the unfortunate situation of supporting a legacy PHP application. You need to add new features (like a REST API), but you don't want all the cruft that goes with PHP development. In this tutorial, I will demonstrate how you can add a REST API to an existing Zend Framework application.

I'll be using [Grape](https://github.com/intridea/grape/) for creating a standalone API because of it's simplicity. The guts of this tutorial applies the same to Rails, Sinatra, etc.

## Assumptions:

This tutorial assumes that you are already familiar with Ruby, Bundler, Rack, and know how to run a simple Rack application.

## Creating the API endpoints

Assuming you have a directory which includes a Gemfile and a config.ru:

```ruby
# Gemfile:
source :rubygems
gem 'grape'

# config.ru
require 'bundler/setup'
Bundler.require

def run_php(*args)
  base_path = File.expand_path('path/to/php-app/bin', __FILE__)
  `php #{base_path}/api_bridge.php #{args.join(' ')}`
end

class MyAPI < Grape::API
  format :json
  resource :groups do
    get do
      run_php 'Groups', 'fetchAll'
    end
  end
end

run MyAPI
```

Here I have simply defined a `/groups` endpoint which responds to a GET request, which shells out to a PHP script and always returns a JSON reponse.

## The PHP bridge

Let's assume that you already have a Zend Framework application, which has a Groups model. We want to call `Groups::fetchAll()` in order to get all the groups and expose it through the API. Here's what the bridge script might look like:

```php
<?php
require dirname(__FILE__) . '/cli-bootstrap.php';

$args = $argv;
$current_file = array_shift($args);
$class = array_shift($args);
$method = array_shift($args);
$arguments = $args;

$ref = new ReflectionClass($class);
$instance = $ref->newInstance();
$result = $ref->getMethod($method)->invokeArgs($instance, $arguments);

if (is_callable(array($result, 'toArray'))) {
	echo json_encode($result->toArray());
} else {
	echo json_encode($result);
}
```

This script simply bootstraps the Zend Framework application (which is outside the scope of this tutorial) in order to autoload our `Groups` class so that we can call `fetchAll()` on it which returns a JSON response.

This was more of a quick proof-of-concept. I don't think this is ready for production usage.

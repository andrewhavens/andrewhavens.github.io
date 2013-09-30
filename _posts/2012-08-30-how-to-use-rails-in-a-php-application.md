---
layout: post
title: "How to use Rails in a PHP application"
date: 2012-08-30
permalink: /posts/19/how-to-use-rails-in-a-php-application
---
Have you ever wanted to slowly transition a PHP application to use Ruby on Rails? You can do this by running Rails and PHP in the same application! It may sound crazy, but when writing PHP code starts driving you crazy, you start to do crazy things. In this tutorial, I will show you what you need to do to be successful.

For demonstration purposes, we'll set up a "/orders" section of the PHP app that uses Rails behind the scenes. The orders section will only allow authenticated users by sharing the logged in user session from the PHP app.

## Assumptions

This guide assumes you will be using:

 - Zend Framework 1.11
 - Rails 3.2.8
 - Apache
 - Passenger Apache module for serving your Rails app

## Directory structure

Let's assume you have a directory which contains your PHP app and Rails app in a single project directory:

```text
project
  |-- php-app
      |-- application
      |-- public
      |-- ...etc
  |-- rails-app
      |-- app
      |-- public
      |-- ...etc
```

## Configuring Apache

First things first: you need to configure Apache to serve your Rails application within your Zend Framework project:

```apache
<VirtualHost *:80>
  ServerName your.app.com
  DocumentRoot /path/to/php-app/public

  <Directory /path/to/php-app/public/orders>
    Options -MultiViews
    RailsBaseURI /
  </Directory>
</VirtualHost>
```

As you can see by the Apache directory configuration, Apache will be looking for a directory called `orders` in our PHP app's public directory. We'll need to create a symlink to our Rails app's **public** directory.

```console
$ cd php-app/public
$ ln -s ../../rails-app/public orders
```

More Passenger configuration options can be found in the Passenger docs under [deploying to a sub-uri](http://www.modrails.com/documentation/Users%20guide%20Apache.html#deploying_rack_to_sub_uri).

Alternatively, if you wanted to use something other than Passenger, you could use Apache's mod_proxy. Setting up mod_proxy is outside the scope of this tutorial, but here's the configuration:

```apache
<VirtualHost *:80>
  ServerName your.app.com
  DocumentRoot /path/to/php-app/public
  ProxyPass /orders http://127.0.0.1:3000/orders
</VirtualHost>
```

Now if we were to add some scaffolding for `orders` and restart our Rails app, everything should work:

```console
$ cd rails-app
$ rails g scaffold Order food:text drink:string
$ touch tmp/restart.txt
$ open http://your.app.com/orders
```

## Sharing Sessions

In order for a user to stay logged in when navigating to our new `/orders` route, we will need to share sessions across both applications. We can do this by storing the session information in the database. However, it's not that simple. Rails and Zend Framework each have their own way of storing session data.

![Session IDs stored in cookies](/assets/posts/19_sessions.png)

We will need to configure both Rails and Zend Framework so they store the session using the same approach.

### Configuring Rails

To start storing session information in the database in the Rails application, do the following:

Enable the following line in `config/initializers/session_store.rb`:

```ruby
YourApp::Application.config.session_store :active_record_store
```

Next you will generate a migration to create the database table to store the session information:

```console
$ rails generate session_migration
```

### Configuring PHP

Now that Rails is configured to store sessions in the database, we need to configure our PHP application to do the same. We can [configure Zend Framework to store session data in the database](http://framework.zend.com/manual/en/zend.application.available-resources.html#zend.application.available-resources.session). Add these lines to your `config.ini` file:

```ini
resources.session.saveHandler.class = "Zend_Session_SaveHandler_DbTable"
resources.session.saveHandler.options.name = "session"
resources.session.saveHandler.options.primary[] = "session_id"
resources.session.saveHandler.options.primary[] = "save_path"
resources.session.saveHandler.options.primary[] = "name"
resources.session.saveHandler.options.primaryAssignment[] = "sessionId"
resources.session.saveHandler.options.primaryAssignment[] = "sessionSavePath"
resources.session.saveHandler.options.primaryAssignment[] = "sessionName"
resources.session.saveHandler.options.modifiedColumn = "modified"
resources.session.saveHandler.options.dataColumn = "session_data"
resources.session.saveHandler.options.lifetimeColumn = "lifetime"
```

...and create the database table...

```sql
CREATE TABLE `session` (
    `session_id` char(32) NOT NULL,
    `save_path` varchar(32) NOT NULL,
    `name` varchar(32) NOT NULL DEFAULT '',
    `modified` int,
    `lifetime` int,
    `session_data` text,
    PRIMARY KEY (`Session_ID`, `save_path`, `name`)
);
```

Zend Framework will now automatically save session information to the database as a serialized array. Let's say you were saving the `user_id` in the session like this:

```php
$session = new Zend_Session_Namespace('Auth');
$session->logged_in_user_id = 47;
```

If you were to view a session record in the database it would look like this:

```text
+----------------------------------+---------------+-----------+------------+----------+-------------------------------------------+
| session_id                       | save_path     | name      | modified   | lifetime | session_data                              |
+----------------------------------+---------------+-----------+------------+----------+-------------------------------------------+
| 729d850de359a98b25a4459362c7bbcc | /var/lib/php5 | PHPSESSID | 1346463131 |     1440 | Auth|a:1:{s:17:"logged_in_user_id";i:47;} |
+----------------------------------+---------------+-----------+------------+----------+-------------------------------------------+
```

**TODO:** Sorry, still working through this part. Any tips, feel free to leave them in the comments.

## Legacy Database Naming Scheme

What do you do if you used camel case instead of snake case for naming your database tables and fields and want to access those through your Rails app? Rather than update all of your PHP models to use snake case, it will be easier to tell active record to use your custom naming scheme.

When you use the Rails generators, you can specify the name of your columns as camel case:

```console
$ rails g scaffold Post Title Body:text
```

...however, the table names and primary key will still be snake case. You will need to manually adjust these in the migration and model.

```ruby
class Post < ActiveRecord::Base
  self.primary_key = 'ID'
  self.table_name = 'Posts'
end
```

But it will be cleaner in the long run if you just define a base class to handle this:

```ruby
class Post < ActiveRecord::MyBase
end

module ActiveRecord
  class MyBase < ActiveRecord::Base

    self.primary_key = 'ID'

    def self.inherited(child)
      self.table_name = child.to_s.pluralize #class name is already camel cased
      super
    end

  end
end
```

Hopefully I've covered everything you need to know in order for this to work. If you find that I've left anything out, or have a criticism of this approach, please leave a comment so you can help others who might have stumbled across this post.

---
layout: post
title: "How to create a new Rails engine which uses RSpec and FactoryGirl for testing"
date: 2016-12-01
permalink: /posts/27/how-to-create-a-new-rails-engine-which-uses-rspec-and-factorygirl-for-testing
---
**Updated** on December 1, 2016 to be compatible with Rails 5.0.

Need to create a Rails engine which uses RSpec and/or Cucumber instead of Test::Unit, and FactoryGirl instead of Fixtures? Here are the steps:

### 1. Create the engine:

```text
rails plugin new gem_name --mountable -T --dummy-path=spec/dummy
```
* `--mountable` tells the generator that you want a namespaced engine
* `-T` tells the generator to skip `Test::Unit`
* `--dummy-path` is the rails app that is generated for your tests. It's called test/dummy by default, but you can choose a different name if you want to.

### 2. Add dependencies in your `Gemfile`:

```ruby
source "http://rubygems.org"

gemspec

group :development, :test do
  gem "rspec-rails"
  gem "factory_girl_rails"
end

group :test do
  gem "cucumber-rails", require: false
  gem "database_cleaner"
end
```

Then `bundle install`.

### 3. Run the installers:

```text
rails generate rspec:install
rails generate cucumber:install
```

### 4. Edit your engine's configuration file to specify RSpec and FactoryGirl:

```ruby
# lib/gem_name/engine.rb
module GemName
  class Engine < ::Rails::Engine
    isolate_namespace GemName

    config.generators do |g|
      g.test_framework :rspec
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
    end
  end
end
```

### 5. Update the locations of the dummy app:

Update this line in the RSpec `rails_helper` config file:
```ruby
# spec/rails_helper.rb
require File.expand_path('dummy/config/environment', __FILE__)
```

Add these lines to the top of your Cucumber support file:
```ruby
# features/support/env.rb
ENV["RAILS_ENV"] ||= "test"
require File.expand_path("../../../spec/dummy/config/environment.rb", __FILE__)
ENV["RAILS_ROOT"] ||= File.dirname(__FILE__) + "../../../spec/dummy"

require 'cucumber/rails'

FactoryGirl.definition_file_paths << File.expand_path("../../../spec/factories", __FILE__)
FactoryGirl.find_definitions
```

### 6. After creating some models and migrations, run the migrations for the test app and the test database:

```text
bundle exec rake app:db:migrate
bundle exec rake app:db:test:prepare
```

Now you have a Rails engine configured to use RSpec, Cucumber, and FactoryGirl. You're ready to start testing!

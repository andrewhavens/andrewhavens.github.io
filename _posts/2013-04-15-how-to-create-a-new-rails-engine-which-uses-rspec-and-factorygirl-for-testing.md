---
layout: post
title: "How to create a new Rails engine which uses RSpec and FactoryGirl for testing"
date: 2013-04-15
permalink: /posts/27/how-to-create-a-new-rails-engine-which-uses-rspec-and-factorygirl-for-testing
---
Need to create a Rails engine which uses RSpec instead of Test::Unit and FactoryGirl instead of fixtures? Here are the steps:

### 1. Create the engine:

```text
rails plugin new gem_name -T --mountable --full --dummy-path=spec/test_app
```
* -T tells the generator to skip Test::Unit
* --mountable tells the generator that you want a namespaced engine
* --full tells the generator that you want app and config directories
* --dummy-path is the rails app that is generated for your tests. It's called test/dummy by default, but I never liked calling it that.

### 2. Add `rails-rspec` and `factory_girl_rails` as a dependencies in your Gemfile:

```ruby
source "http://rubygems.org"
gemspec
gem "rspec-rails", "~> 2.12.2"
gem "factory_girl_rails", "~> 4.0"
```

Then `bundle install`.

### 3. Now edit your engine's lib/gem_name/engine.rb file to include rspec:

```ruby
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

### 4. Run the rspec generator:

```text
rails generate rspec:install
```

### 5. After creating some models and migrations, run the migrations for the test app and the test database:

```text
bundle exec rake app:db:migrate
bundle exec rake app:db:test:prepare
```

Now you have a Rails engine configured to use RSpec. You're ready to start testing!

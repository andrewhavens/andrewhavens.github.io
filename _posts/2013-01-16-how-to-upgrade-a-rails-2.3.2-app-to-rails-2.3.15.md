---
layout: post
title: "How to upgrade a Rails 2.3.2 app to Rails 2.3.15"
date: 2013-01-16
permalink: /posts/23/how-to-upgrade-a-rails-2.3.2-app-to-rails-2.3.15
---
I recently needed to upgrade a legacy Rails app to take advantage of the latest security fixes. It turned out to be more work than I was expecting, so hopefully this will help you save a little time.

The environment prior to upgrade:

 - rails 2.3.2
 - ruby 1.8.6
 - rack 1.1.5
 - rubygems 1.3.1
 - mongrel 1.1.5
 - nginx

I hade one console tab open tailing the mongrel log at all times so I could see when something broke. Having not worked with a mongrel rails app, I didn't know where I would find the log, but it was in the app's log directory (of course).

The first step was to install the Rails gem:

```console
sudo gem install rails -v 2.3.15
```

If you see these messages, just ignore them because they don't cause an error:

```text
config.load_paths is deprecated and removed in Rails 3, please use autoload_paths instead
```

Next, update rails version in `config/environment.rb`:

```ruby
RAILS_GEM_VERSION = '2.3.15' unless defined? RAILS_GEM_VERSION
```

### Vendored Gems
If your app has a vendored version of rails, remove it because we're going to use the one we just installed:

```console
rm -rf vendor/rails
```

If you have any files (non-directories) in `vendor/gems`, remove those too:

```console
 rm vendor/gems/init.rb
```

If you have any errors in the log about your vendored gems missing .specification files, make sure the gem is installed with ruby gems first, then use the rake task to create the specs:

```console
rake gems:refresh_specs
```

### Rake

If you have any rake errors, you will see the message of what you need to fix.

### RubyGems

You might have seen this error before upgrading Rails:

```text
Warning: Gem::Dependency#version_requirements is deprecated and will be removed on or after August 2010.  Use #requirement
```

And if you see this error after upgrading Rails...

```text
/usr/lib/ruby/gems/1.8/gems/rails-2.3.15/lib/rails/gem_dependency.rb:81:in `add_load_paths': undefined method `requirement' for #<Rails::GemDependency:0xb71d178c> (NoMethodError)
```

...you will need a newer version of rubygems:

```console
sudo gem install rubygems-update -v='1.4.2'
sudo update_rubygems
```

### Mongrel

If you are using mongrel and come across this error:

```text
Error calling Dispatcher.dispatch #<NoMethodError: private method `split' called for nil:NilClass>
```

...there is a [patch](https://gist.github.com/826692) to fix this. Create an initializer in your Rails app called `mongrel.rb` and paste this in:

```ruby
  module Rack
    module Utils
      class HeaderHash < Hash
        def [](k)
          super(@names[k]) if @names[k]
          super(@names[k.downcase])
        end
      end
    end
  end
  
  class Mongrel::CGIWrapper
    def header_with_rails_fix(options = 'text/html')
      @head['cookie'] = options.delete('cookie').flatten.map { |v| v.sub(/^\n/,'') } if options.class != String and options['cookie']
      header_without_rails_fix(options)
    end
    alias_method_chain :header, :rails_fix
  end
  
  module ActionController
    class CGIHandler
      def self.dispatch_cgi(app, cgi, out = $stdout)
        env = cgi.__send__(:env_table)
        env.delete "HTTP_CONTENT_LENGTH"
        cgi.stdinput.extend ProperStream
        env["SCRIPT_NAME"] = "" if env["SCRIPT_NAME"] == "/"
        env.update({
          "rack.version" => [0,1],
          "rack.input" => cgi.stdinput,
          "rack.errors" => $stderr,
          "rack.multithread" => false,
          "rack.multiprocess" => true,
          "rack.run_once" => false,
          "rack.url_scheme" => ["yes", "on", "1"].include?(env["HTTPS"]) ? "https" : "http"
        })
        env["QUERY_STRING"] ||= ""
        env["HTTP_VERSION"] ||= env["SERVER_PROTOCOL"]
        env["REQUEST_PATH"] ||= "/"
        env.delete "PATH_INFO" if env["PATH_INFO"] == ""
        status, headers, body = app.call(env)
        begin
          out.binmode if out.respond_to?(:binmode)
          out.sync = false if out.respond_to?(:sync=)
          headers['Status'] = status.to_s
          if headers['Set-Cookie']
            headers['cookie'] = headers.delete('Set-Cookie').split("\n")
          end
          out.write(cgi.header(headers))
          body.each { |part|
            out.write part
            out.flush if out.respond_to?(:flush)
          }
        ensure
          body.close if body.respond_to?(:close)
        end
      end
    end
  end
```

### Active Merchant
Do you need to update [Active Merchant to a version compatible with Ruby 1.8.6 and Rails 2.3.15](https://groups.google.com/d/msg/activemerchant/LSbI0uEaf0I/OThWdddFTtwJ)?

```console
gem install activemerchant -v 1.12.0
```



And hopefully, at this point, your Rails upgrade is up and running again!

[![Build Status](https://secure.travis-ci.org/lassebunk/metamagic.png)](http://travis-ci.org/lassebunk/metamagic)

Metamagic
=========

Metamagic is a simple [Ruby on Rails](http://rubyonrails.org) plugin for creating meta tags.

Installation
------------

In your *Gemfile*:

```ruby
gem 'metamagic'
```
  
Then run `bundle install`.

Examples
--------

### Basic usage

In your *app/views/layouts/application.html.erb*:

```erb
<head>
  <%= metamagic %>
  ...
</head>
```

Then, at the top of your view, e.g. *app/views/posts/show.html.erb*:

```erb
<%
meta :title => "My title",
     :description => "My description",
     :keywords => %w(keyword1 keyword2 keyword3)
%>
```

This will generate the following:

```html
<head>
  <title>My title</title>
  <meta content="My description" name="description" />
  <meta content="keyword1, keyword2, keyword3" name="keywords" />
  ...
</head>
```

### Specifying default meta tag values

It's possible to specify default values to be shown if a view doesn't specify its own values. In your *app/views/layouts/application.html.erb*:

```erb
<head>
  <%= metamagic :title => "My default title", :description => "My default description.", :keywords => %w(keyword1 keyword2 keyword3) %>
  ...
</head>
```

These values are then inserted if a view doesn't set others.

### Custom meta tags

For custom meta tags, just call it like this in the top of your view:

```erb
<%
meta :my_custom_tag => "My custom value"
%>
```
  
This will generate the following:

```html
<head>
  ...
  <meta content="My custom value" name="my_custom_tag" />
  ...
</head>
```

### Custom properties (like Open Graph)

With custom properties:

```erb
<%
meta [:property => "og:image", :content => "http://mydomain.com/images/my_image.jpg"]
%>
```

This will generate the following:

```html
<head>
  ...
  <meta content="http://mydomain.com/images/my_image.jpg" property="og:image" />
  ...
</head>
```

Requirements
------------

* Rails 3.0 or above
* Ruby 1.9 or above

Versioning
----------

Follows [semantic versioning](http://semver.org/).

Contributing
------------

1. Fork the project
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add new feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new pull r
equest

Contributors
------------

* [See the list of contributors](https://github.com/lassebunk/metamagic/graphs/contributors)

Copyright (c) 2010-2013 [Lasse Bunk](http://lassebunk.dk), released under the MIT license
[![Build Status](https://secure.travis-ci.org/lassebunk/metamagic.png)](http://travis-ci.org/lassebunk/metamagic)

Metamagic
=========

Metamagic is a simple [Ruby on Rails](http://rubyonrails.org) plugin for creating meta tags.
It supports regular meta tags, [OpenGraph](http://ogp.me/) (Facebook), [Twitter Cards](https://dev.twitter.com/docs/cards/types/summary-card), and custom tags.

See the [changelog](https://github.com/lassebunk/metamagic/blob/master/CHANGELOG.md) for changes in version 3.0.

Installation
------------

In your *Gemfile*:

```ruby
gem 'metamagic', '3.0.0.beta1'
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
meta title: "My Title",
     description: "My description",
     keywords: %w(keyword1 keyword2 keyword3)
%>
```

This will generate the following:

```html
<head>
  <title>My Title</title>
  <meta content="My description" name="description" />
  <meta content="keyword1, keyword2, keyword3" name="keywords" />
  ...
</head>
```

### Shortcut helpers

For easy setting of meta tags, you can use the shortcut helpers like this:

```erb
<%
title "My Title"
description "My description"
keywords %w(keyword1 keyword2 keyword3)
%>
```

This will generate the following:

```html
<head>
  <title>My Title</title>
  <meta content="My description" name="description" />
  <meta content="keyword1, keyword2, keyword3" name="keywords" />
  ...
</head>
```

**Note:** Shortcut helpers will never override methods already present in the view context, so for example if you have a method named `title`, this will not be overridden.

### Specifying default meta tag values

It's possible to specify default values to be shown if a view doesn't specify its own values. In your *app/views/layouts/application.html.erb*:

```erb
<head>
  <%= metamagic title: "My default title", description: "My default description.", keywords: %w(keyword1 keyword2 keyword3) %>
  ...
</head>
```

These values are then inserted if a view doesn't set others.

### Custom meta tags

For custom meta tags, you can use it like this:

```erb
<%
meta my_custom_name: "My custom value"
%>
```
  
This will generate the following:

```html
<head>
  ...
  <meta content="My custom value" name="my_custom_name" />
  ...
</head>
```

### Custom properties

#### OpenGraph (Facebook)

```erb
<%
meta og: {
  image: "http://mydomain.com/images/my_image.jpg"
}
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

The above can also be written with the shortcut helper:

```erb
<%
og image: "http://mydomain.com/images/my_image.jpg"
%>
```

#### Twitter Cards

```erb
<%
meta twitter: {
  card: "summary",
  site: "@flickr"
}
%>
```

This will generate the following:

```html
<head>
  ...
  <meta content="summary" property="twitter:card" />
  <meta content="@flickr" property="twitter:site" />
  ...
</head>
```

The above can also be written with the shortcut helper:

```erb
<%
twitter card: "summary",
        site: "@flickr"
%>
```

### Custom tags

You can add custom rendering for tag prefixes you specify.

In *config/initializers/metamagic.rb*:

```ruby
Metamagic::Renderer.register_tag_type :custom, ->(key, value) { tag(:custom_tag, first: key, second: value) }
```

In your view:

```erb
<%
meta title: "My Title",
     custom: {
       key_one: "My first key",
       key_two: "My second key"
     }
%>
```

This will render the following:

```html
<title>My Title</title>
<custom_tag first="custom:key_one" second="My first key" />
<custom_tag first="custom:key_two" second="My second key" />
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
3. Make your changes and make sure the tests pass (run `rake`)
4. Commit your changes (`git commit -am 'Add new feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new pull request

Contributors
------------

* [See the list of contributors](https://github.com/lassebunk/metamagic/graphs/contributors)

Copyright (c) 2010-2014 [Lasse Bunk](http://lassebunk.dk), released under the MIT license
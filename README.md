[![Build Status](https://secure.travis-ci.org/lassebunk/metamagic.png)](http://travis-ci.org/lassebunk/metamagic)

![Meta Magic Motherfuckers](http://i.imgur.com/4KtY4qX.png)

Metamagic
=========

Metamagic is a simple [Ruby on Rails](http://rubyonrails.org) plugin for creating meta tags.
It supports regular meta tags, [OpenGraph](http://ogp.me/) (Facebook), [Twitter Cards](https://dev.twitter.com/docs/cards/types/summary-card), and custom tags.

See the [changelog](https://github.com/lassebunk/metamagic/blob/master/CHANGELOG.md) for changes in version 3.0.

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

At the top of your view, e.g. *app/views/posts/show.html.erb*:

```erb
<%
meta title: "My Title",
     description: "My description",
     keywords: %w(keyword1 keyword2 keyword3)
%>
```

And in *app/views/layouts/application.html.erb*:

```erb
<head>
  <%= metamagic %>
  ...
</head>
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

### Using templates

Templates can be used to insert meta values from your views into your layouts.
This is usable for example if you want to add something to your title on all
pages, or have some default keywords added to all pages. Templates work with
all tag types, including OpenGraph, Twitter, and others.

See below for examples on using templates.

#### Title templates

Title templates can be used to automatically insert the name of your site into the meta title.

In your template:

```erb
<%
meta title: "My Title"
%>
```

In your layout:

```erb
<%
metamagic site: "My Site", title: [:title, :site], separator: " — "
%>
```

This will render the following:

```html
<head>
  <title>My Title — My Site</title>
  ...
</head>
```

The default separator is ` - `.

If you hadn't set the title in your view, it would just display the site name.

You can also use a proc to enable custom processing:

```erb
<%
metamagic site: "My Site", title: -> { title.include?(site) ? title : "#{title} — #{site}" }
%>
```

This will insert the site name only if it is not already present in the title.

You could also do this with a view helper. I use this in one of my websites:

```ruby
module ApplicationHelper
  def meta_title_for(title, site)
    return site if title.blank?
    title.include?(site) ? title : "#{title} — #{site}"
  end
end
```

The proc is still needed in the layout to ensure the right context for the template:

```erb
<%
metamagic site: "My Site", title: -> { meta_title_for(title, site) }
%>
```

#### Keywords template

Keyword templates can be used to add some default keywords to all pages on your site.

In your template:

```erb
<%
meta keywords: %{one two three}
%>
```

In your layout:

```erb
<%
metamagic keywords: [:keywords, "four", "five", "six"]
%>
```

This will render the following:

```html
<head>
  <meta content="one, two, three, four, five, six" name="keywords" />
  ...
</head>
```

#### Adding templates for other tag types

Templates are supported on all tag types. You can access the values set in the
view by replacing colons (`:`) in your meta keys with underscores (`_`), so for
example `og:image` can be accessed with `og_image`.

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

Shortcut helpers return the value you send to them, so you can dry up your code by setting the title once in e.g. a `<h1>` tag, like this:

```erb
<h1><%= title "My Title" %></h1>
```

This is the same as setting the title at the top of your view.

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

### Adding relation links

You can add `<link rel="xx" href="xx">` tags like this:

```erb
<%
meta rel: {
  author: "http://test.com/author.html",
  publisher: "http://test.com/publisher.html"
}
%>
```

Or using the `rel` shortcut helper:

```erb
<%
rel author: "http://test.com/author.html",
    publisher: "http://test.com/publisher.html"
%>
```

This will generate the following:

```html
<head>
  ...
  <link href="http://test.com/author.html" rel="author" />
  <link href="http://test.com/publisher.html" rel="publisher" />
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
  <meta content="summary" name="twitter:card" />
  <meta content="@flickr" name="twitter:site" />
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

#### Other custom properties

You can add custom properties like this:

```erb
<%
meta property: {
  one: "Property One",
  two: "Property Two",
  nested: {
    a: "Nested A",
    b: "Nested B"
  }
}
%>
```

This will generate the following:

```html
<head>
  ...
  <meta content="Property One" property="one" />
  <meta content="Property Two" property="two" />
  <meta content="Nested A" property="nested:a" />
  <meta content="Nested B" property="nested:b" />
  ...
</head>
```

The above could also be written with the `property` shortcut helper:

```erb
<%
property one: "Property One",
         two: "Property Two",
         nested: {
           a: "Nested A",
           b: "Nested B"
         }
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

When you register a new tag type, a shortcut helper is automatically defined. The above could therefore also be written as:

```erb
<%
custom key_one: "My first key",
       key_two: "My second key"
%>
```

Requirements
------------

* Rails 3.0 or above
* Ruby 1.9 or above

Contributing
------------

1. Fork the project
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Make your changes, including tests, and make sure the tests pass (run `rake`)
4. Commit your changes (`git commit -am 'Add new feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create new pull request

Contributors
------------

* [See the list of contributors](https://github.com/lassebunk/metamagic/graphs/contributors)

Copyright (c) 2010-2014 [Lasse Bunk](http://lassebunk.dk), released under the MIT license

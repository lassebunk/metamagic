Metamagic is a simple Ruby on Rails plugin for creating meta tags.

Installation
------------

In your *Gemfile*:

```ruby
gem 'metamagic'
```
  
Then run `bundle install`.

Example
-------

In your *application.html.erb*:

```erb
<head>
  <title>My Site</title>
  ...
  <%= metamagic :title => "My default title", :description => "My default description.", :keywords => %w(keyword1 keyword2 keyword3) %>
  ...
</head>
```

For custom meta tags, just call it like this in the top of your view:

```erb
<%
meta :title => "My title", :my_custom_tag => "My custom value"
%>
```
  
With custom properties:

```erb
<%
meta [:property => "og:image", :content => "http://mydomain.com/images/my_image.jpg"]
%>
```

And then just put your content below.

Title meta tags will automatically be translated to `<title>` tags.

Contributors
------------

* [See the list of contributors](https://github.com/lassebunk/metamagic/graphs/contributors)

Copyright (c) 2010-2013 [Lasse Bunk](http://lassebunk.dk), released under the MIT license

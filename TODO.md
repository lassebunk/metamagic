Ideas and todos
---------------

* Idea: Support more versatile meta syntax, like:
  
  ```ruby
  meta title: "My test title",
       description: "My description",
       property: { "og:image" => "http://bla.dk",
                   "og:more"  => "bla bla" },
       "http-equiv" => { "cache-control" => "no-cache",
                         "content-type"  => "text/html;charset=UTF-8" }
  ```

  The change is that a meta value can be a hash so if you pass `meta property: { "bla" => "test" }` it will generate `<meta property="bla" content="test" />`.
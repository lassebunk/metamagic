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

  Or maybe better, automatic generation of `property="xx"` if given value is a hash. `http-equiv` then needs to be handled manually.
  
  ```ruby
  meta title: "Test",
       og: { image: "http://bla.dk/test.png",
             title: "Test title" },
       twitter: { card: summary,
                  title: "Test" },
       "http-equiv" => { "cache-control" => "no-cache",
                         "content-type"  => "text/html;charset=UTF-8" }
  ```

  The change is that a meta value can be a hash so if you pass `meta property: { "bla" => "test" }` it will generate `<meta property="bla" content="test" />`.

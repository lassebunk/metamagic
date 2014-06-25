require 'test_helper'

class HelperMethodsTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "meta tags generation" do
    meta title: "My Title",
         description: "My description.",
         keywords: ["One", "Two", "Three"]

    assert_equal %{<title>My Title</title>\n<meta content="My description." name="description" />\n<meta content="One, Two, Three" name="keywords" />},
                 metamagic
  end

  test "default meta tags" do
    meta title: "Test Title",
         test: "Test tag"

    assert_equal %{<title>Test Title</title>\n<meta content="Test tag" name="test" />\n<meta content="Default description" name="description" />},
                 metamagic(title: "Default Title", description: "Default description", test: "Default test")
  end

  test "not adding existing meta tags" do
    meta title: "Test Title",
         description: "Test description."

    meta title: "Second Title",
         description: "Second description."

    assert_equal %{<title>Test Title</title>\n<meta content="Test description." name="description" />},
                 metamagic
  end

  test "open graph" do
    meta title: "Test Title",
         og: {
           image: {
             url: "http://test.com/image.jpg",
             type: "image/png"
           }
         }

    assert_equal %{<title>Test Title</title>\n<meta content="http://test.com/image.jpg" property="og:image:url" />\n<meta content="image/png" property="og:image:type" />},
                 metamagic
  end

  test "twitter cards" do
    meta title: "Test Title",
         twitter: {
           card: :summary,
           site: "@flickr"
         }

    assert_equal %{<title>Test Title</title>\n<meta content="summary" property="twitter:card" />\n<meta content="@flickr" property="twitter:site" />},
                 metamagic
  end

  test "custom tags" do
    Metamagic::Renderer.register_tag_type :custom, ->(key, value) { tag(:custom_tag, one: key, two: value) }

    meta title: "Test Title",
         custom: {
           first: "This is the first",
           second: "This is the second"
         }

    assert_equal %{<title>Test Title</title>\n<custom_tag one="custom:first" two="This is the first" />\n<custom_tag one="custom:second" two="This is the second" />},
                 metamagic
  end

  test "shortcut helpers" do
    title "My Title"
    description "My description"
    keywords %w{one two three}
    og image: "http://test.com/img.jpg"
    twitter card: :summary, site: "@flickr"
    meta bla: "Test"

    assert_equal %{<title>My Title</title>\n<meta content="My description" name="description" />\n<meta content="one, two, three" name="keywords" />\n<meta content="Test" name="bla" />\n<meta content="summary" property="twitter:card" />\n<meta content="@flickr" property="twitter:site" />\n<meta content="http://test.com/img.jpg" property="og:image" />},
                 metamagic
  end

  test "property helper" do
    meta property: { one: "Property One", two: "Property Two", "og:image" => "http://test.com/image.png", nested: { a: "Nested A" } }
    property two: "Property Two second", three: "Property Three", nested: { a: "Nested A second", b: "Nested B" }
    og title: "My Title", image: "http://test.com/image2.png"

    assert_equal %{<meta content="Property One" property="one" />\n<meta content="Property Two" property="two" />\n<meta content="http://test.com/image.png" property="og:image" />\n<meta content="Nested A" property="nested:a" />\n<meta content="Property Three" property="three" />\n<meta content="Nested B" property="nested:b" />\n<meta content="My Title" property="og:title" />},
                 metamagic
  end

  test "sorting tags" do
    twitter card: :summary
    og image: "http://test.com/image.png"
    description "My description."
    keywords %w{one two three}
    title "My Title"

    assert_equal %{<title>My Title</title>\n<meta content="one, two, three" name="keywords" />\n<meta content="My description." name="description" />\n<meta content="http://test.com/image.png" property="og:image" />\n<meta content="summary" property="twitter:card" />},
                 metamagic
  end

  test "old property definition" do
    assert_raises ArgumentError do
      meta [:property => "og:image", :content => "http://mydomain.com/images/my_image.jpg"]
    end
  end

  test "property array" do
    og image: ["one.jpg", "two.jpg"]

    assert_equal %{<meta content="one.jpg" property="og:image" />\n<meta content="two.jpg" property="og:image" />},
                 metamagic
  end

  test "nil property" do
    og title: "Test Title",
       image: nil

    assert_equal %{<meta content="Test Title" property="og:title" />},
                 metamagic
  end

  test "nil in property array" do
    og title: "Test Title",
       image: [nil]

    assert_equal %{<meta content="Test Title" property="og:title" />},
                 metamagic
  end

  test "empty property array" do
    og image: "http://test.com/image.png",
       book: {
         author: ["Leif Davidsen", "Anders Mogensen"],
         tag: []
       }

    assert_equal %{<meta content="http://test.com/image.png" property="og:image" />\n<meta content="Leif Davidsen" property="og:book:author" />\n<meta content="Anders Mogensen" property="og:book:author" />},
                 metamagic
  end
end

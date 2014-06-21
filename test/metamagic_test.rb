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
end

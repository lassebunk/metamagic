require 'test_helper'

class HelperMethodsTest < ActionView::TestCase
  include Metamagic::HelperMethods

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

  test "meta tags using property attribute rather than name" do
    meta [property: "og:url", content: "http://test.url"]

    assert_equal %{<meta content="http://test.url" property="og:url" />},
                 metamagic
  end

  test "overriding default meta tags if the property attribute matches" do
    meta [property: "og:url", content: "http://override.url"]

    assert_equal %{<meta content="http://override.url" property="og:url" />},
                 metamagic([property: "og:url", content: "http://default.url"])
  end


end

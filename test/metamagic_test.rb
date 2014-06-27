require 'test_helper'

class MetamagicTest < ActionView::TestCase
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

  test "not adding existing meta tags by shortcut helpers" do
    meta title: "Test Title",
         description: "Test description."

    title "Second Title"
    description "Second description."

    assert_equal %{<title>Test Title</title>\n<meta content="Test description." name="description" />},
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

    assert_equal %{<title>My Title</title>\n<meta content="My description" name="description" />\n<meta content="one, two, three" name="keywords" />},
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
end

require 'test_helper'

class MetamagicTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "meta tags generation" do
    meta title: "My Title",
         description: "My description.",
         keywords: ["One", "Two", "Three"]

    assert_equal_segment %{<title>My Title</title>\n<meta content="My description." name="description" />\n<meta content="One, Two, Three" name="keywords" />},
                 metamagic
  end

  test "default meta tags" do
    meta title: "Test Title",
         test: "Test tag"

    assert_equal_segment %{<title>Test Title</title>\n<meta content="Test tag" name="test" />\n<meta content="Default description" name="description" />},
                 metamagic(title: "Default Title", description: "Default description", test: "Default test")
  end

  test "default meta tags containing colons" do
    meta title: "Test Title",
         test: "Test tag"

    assert_equal_segment %{<title>Test Title</title>\n<meta content="Test tag" name="test" />\n<meta content="Default\n:something" name="description" />},
                 metamagic(title: "Default:Title", description: "Default\n:something", test: "Default test")
  end

  test "not adding existing meta tags" do
    meta title: "Test Title",
         description: "Test description."

    meta title: "Second Title",
         description: "Second description."

    assert_equal_segment %{<title>Test Title</title>\n<meta content="Test description." name="description" />},
                 metamagic
  end

  test "not adding existing meta tags by shortcut helpers" do
    meta title: "Test Title",
         description: "Test description."

    title "Second Title"
    description "Second description."

    assert_equal_segment %{<title>Test Title</title>\n<meta content="Test description." name="description" />},
                 metamagic
  end

  test "shortcut helpers" do
    title "My Title"
    description "My description"
    keywords %w{one two three}

    assert_equal_segment %{<title>My Title</title>\n<meta content="My description" name="description" />\n<meta content="one, two, three" name="keywords" />},
                 metamagic
  end

  test "shortcut helper returns value" do
    assert_equal_segment "My Title", title("My Title")
    assert_equal_segment "My Description", description("My Description")
    assert_equal_segment %w{one two three}, keywords(%w{one two three})
  end

  test "not adding templates from views" do
    title "This is a :nonexistent_key"

    assert_equal_segment %{<title>This is a :nonexistent_key</title>},
                 metamagic
  end

  test "sorting tags" do
    twitter card: :summary
    og image: "http://test.com/image.png"
    description "My description."
    keywords %w{one two three}
    title "My Title"

    assert_equal_segment %{<title>My Title</title>\n<meta content="one, two, three" name="keywords" />\n<meta content="My description." name="description" />\n<meta content="http://test.com/image.png" property="og:image" />\n<meta content="summary" name="twitter:card" />},
                 metamagic
  end
end

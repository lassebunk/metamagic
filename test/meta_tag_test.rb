require 'test_helper'

class MetaTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "meta tags" do
    meta keywords: %w{one two three},
         description: "My description"

    assert_equal_segment %{<meta content="one, two, three" name="keywords" />\n<meta content="My description" name="description" />},
                 metamagic
  end

  test "shortcut helpers" do
    keywords %w{one two three}
    description "My description"

    assert_equal_segment %{<meta content="one, two, three" name="keywords" />\n<meta content="My description" name="description" />},
                 metamagic
  end

  test "nil meta value" do
    title "Test Title"
    description nil

    assert_equal_segment %{<title>Test Title</title>},
                 metamagic
  end

  test "array as meta value" do
    keywords %w{one two three}

    assert_equal_segment %{<meta content="one, two, three" name="keywords" />},
                 metamagic
  end

  test "empty array as meta value" do
    title "Test Title"
    keywords []

    assert_equal_segment %{<title>Test Title</title>},
                 metamagic
  end

  test "nil in array as meta value" do
    title "Test Title"
    keywords ["one", nil, "two"]

    assert_equal_segment %{<title>Test Title</title>\n<meta content="one, two" name="keywords" />},
                 metamagic
  end

  test "nil only array as meta value" do
    title "Test Title"
    keywords [nil]

    assert_equal_segment %{<title>Test Title</title>},
                 metamagic
  end

  test "keywords template" do
    keywords %w{added keywords}

    assert_equal_segment %{<meta content="added, keywords, default, from, layout" name="keywords" />},
                 metamagic(keywords: [:keywords, "default", "from", "layout"])
  end

  test "keywords template with no keywords" do
    assert_equal_segment %{<meta content="default, from, layout" name="keywords" />},
                 metamagic(keywords: [:keywords, "default", "from", "layout"])
  end

  test "unique values using templates" do
    keywords %w{added keywords}

    assert_equal_segment %{<meta content="added, keywords, default, from, layout" name="keywords" />},
                 metamagic(keywords: [:keywords, "added", "default", "keywords", "from", "layout"])
  end

  test "html safe keywords" do
    keywords ["one", "two &rarr; test".html_safe, "three"]

    assert_equal_segment %{<meta content="one, two &rarr; test, three" name="keywords" />},
                 metamagic
  end

  test "html unsafe keywords" do
    keywords ["one", "two &rarr; test", "three"]

    assert_equal_segment %{<meta content="one, two &amp;rarr; test, three" name="keywords" />},
                 metamagic
  end
end
require 'test_helper'

class MetaTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "nil meta value" do
    title "Test Title"
    description nil

    assert_equal %{<title>Test Title</title>},
                 metamagic
  end

  test "array as meta value" do
    keywords %w{one two three}

    assert_equal %{<meta content="one, two, three" name="keywords" />},
                 metamagic
  end

  test "empty array as meta value" do
    title "Test Title"
    keywords []

    assert_equal %{<title>Test Title</title>},
                 metamagic
  end

  test "nil in array as meta value" do
    title "Test Title"
    keywords ["one", nil, "two"]

    assert_equal %{<title>Test Title</title>\n<meta content="one, two" name="keywords" />},
                 metamagic
  end

  test "nil only array as meta value" do
    title "Test Title"
    keywords [nil]

    assert_equal %{<title>Test Title</title>},
                 metamagic
  end
end
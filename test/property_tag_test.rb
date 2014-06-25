require 'test_helper'

class PropertyTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

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

  test "nil only property array" do
    og title: "Test Title",
       image: [nil]

    assert_equal %{<meta content="Test Title" property="og:title" />},
                 metamagic
  end

  test "nil in property array" do
    og title: "Test Title",
       image: ["one.jpg", nil, "two.jpg"]

    assert_equal %{<meta content="Test Title" property="og:title" />\n<meta content="one.jpg" property="og:image" />\n<meta content="two.jpg" property="og:image" />},
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
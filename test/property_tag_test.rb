require 'test_helper'

class PropertyTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "property tags" do
    meta property: { one: "Property One", two: "Property Two", "og:image" => "http://test.com/image.png", nested: { a: "Nested A" } }
    property two: "Property Two second", three: "Property Three", nested: { a: "Nested A second", b: "Nested B" }

    assert_equal_segment %{<meta content="Property One" property="one" />\n<meta content="Property Two" property="two" />\n<meta content="http://test.com/image.png" property="og:image" />\n<meta content="Nested A" property="nested:a" />\n<meta content="Property Three" property="three" />\n<meta content="Nested B" property="nested:b" />},
                 metamagic
  end

  test "property array" do
    og image: ["one.jpg", "two.jpg"]

    assert_equal_segment %{<meta content="one.jpg" property="og:image" />\n<meta content="two.jpg" property="og:image" />},
                 metamagic
  end

  test "nil property" do
    og title: "Test Title",
       image: nil

    assert_equal_segment %{<meta content="Test Title" property="og:title" />},
                 metamagic
  end

  test "nil only property array" do
    og title: "Test Title",
       image: [nil]

    assert_equal_segment %{<meta content="Test Title" property="og:title" />},
                 metamagic
  end

  test "nil in property array" do
    og title: "Test Title",
       image: ["one.jpg", nil, "two.jpg"]

    assert_equal_segment %{<meta content="Test Title" property="og:title" />\n<meta content="one.jpg" property="og:image" />\n<meta content="two.jpg" property="og:image" />},
                 metamagic
  end

  test "empty property array" do
    og image: "http://test.com/image.png",
       book: {
         author: ["Leif Davidsen", "Anders Mogensen"],
         tag: []
       }

    assert_equal_segment %{<meta content="http://test.com/image.png" property="og:image" />\n<meta content="Leif Davidsen" property="og:book:author" />\n<meta content="Anders Mogensen" property="og:book:author" />},
                 metamagic
  end

  test "property template" do
    og image: "http://test.com/image.jpg"

    assert_equal_segment %{<meta content="http://test.com/image.jpg" property="og:image" />\n<meta content="http://test.com/image2.jpg" property="og:image" />},
                 metamagic(og: { image: [:og_image, "http://test.com/image2.jpg"] })
  end
end
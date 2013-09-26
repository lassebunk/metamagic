require 'test_helper'

class HelperMethodsTest < ActionView::TestCase
  include Metamagic::HelperMethods

  test "meta tags generation" do
    meta title: "My Title",
         description: "My description.",
         keywords: ["One", "Two", "Three"]

    assert_equal %{<title>My Title</title>\n<meta content="My description." name="description" />\n<meta content="One, Two, Three" name="keywords" />}, metamagic
  end
end

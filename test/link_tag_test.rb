require 'test_helper'

class LinkTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "link rel" do
    meta rel: {
      author: "http://test.com/author.html",
    }
    rel publisher: "http://test.com/publisher.html"

    assert_equal_segment %{<link href="http://test.com/author.html" rel="author" />\n<link href="http://test.com/publisher.html" rel="publisher" />},
                 metamagic
  end
end
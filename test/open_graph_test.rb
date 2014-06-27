require 'test_helper'

class OpenGraphTest < ActionView::TestCase
  include Metamagic::ViewHelper

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
end
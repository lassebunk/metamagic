require "test_helper"

class CustomTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

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
end
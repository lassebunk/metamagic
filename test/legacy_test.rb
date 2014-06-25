require 'test_helper'

class LegacyTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "old property definition" do
    assert_raises ArgumentError do
      meta [:property => "og:image", :content => "http://mydomain.com/images/my_image.jpg"]
    end
  end
end
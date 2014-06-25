require 'test_helper'

class TitleTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "nil title" do
    title nil
    description "Test description"

    assert_equal %{<meta content="Test description" name="description" />},
                 metamagic
  end
end
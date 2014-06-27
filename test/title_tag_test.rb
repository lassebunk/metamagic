require 'test_helper'

class TitleTagTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "title tag" do
    meta title: "My Title"

    assert_equal %{<title>My Title</title>},
                 metamagic
  end

  test "shortcut helper" do
    title "My Title"

    assert_equal %{<title>My Title</title>},
                 metamagic
  end

  test "nil title" do
    title nil
    description "Test description"

    assert_equal %{<meta content="Test description" name="description" />},
                 metamagic
  end
end
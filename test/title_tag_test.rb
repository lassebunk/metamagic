require 'test_helper'

class TitleTagTest < ActionView::TestCase
  include Metamagic::ViewHelper
  include ApplicationHelper

  test "title tag" do
    meta title: "My Title"

    assert_equal_segment %{<title>My Title</title>},
                 metamagic
  end

  test "shortcut helper" do
    title "My Title"

    assert_equal_segment %{<title>My Title</title>},
                 metamagic
  end

  test "nil title" do
    title nil
    description "Test description"

    assert_equal_segment %{<meta content="Test description" name="description" />},
                 metamagic
  end

  test "title template" do
    title "Test Title"

    assert_equal_segment %{<title>Test Title - My Site</title>},
                 metamagic(site: "My Site", title: ":title - :site")
  end

  test "title template with no title set" do
    assert_equal_segment %{<title> - My Site</title>},
                 metamagic(site: "My Site", title: ":title - :site")
  end

  test "title separator" do
    title "Test Title"

    assert_equal_segment %{<title>Test Title - My Site</title>},
                 metamagic(site: "My Site", title: [:title, :site])
  end

  test "custom title separator" do
    title "Test Title"

    assert_equal_segment %{<title>Test Title | My Site</title>},
                 metamagic(site: "My Site", separator: " | ", title: [:title, :site])
  end

  test "title separator with no title" do
    assert_equal_segment %{<title>My Site</title>},
                 metamagic(site: "My Site", title: [:title, :site])
  end

  test "title template with nil site" do
    title "Test Title"

    assert_raises RuntimeError do
      metamagic(title: ":title - :site")
    end
  end

  test "title template proc" do
    title "Test Title"

    assert_equal_segment %{<title>Site: My Site - Title: Test Title</title>},
                 metamagic(site: "My Site", title: -> { "Site: #{site} - Title: #{title}" })
  end

  test "title template from view helper" do
    title "Test Title"

    assert_equal_segment %{<title>From view helper: Test Title - My Site</title>},
                 metamagic(site: "My Site", title: -> { meta_title_for(site, title) })
  end

  test "html safe titles" do
    title "My Site &rarr; Test".html_safe

    assert_equal_segment %{<title>My Site &rarr; Test</title>},
                 metamagic
  end

  test "html safe titles in template" do
    title "Test &rarr; Test".html_safe

    assert_equal_segment %{<title>Test &rarr; Test - My Site</title>},
                 metamagic(title: ":title - :site", site: "My Site")
  end

  test "html unsafe titles" do
    title "My Site &rarr; Test"

    assert_equal_segment %{<title>My Site &amp;rarr; Test</title>},
                 metamagic
  end

  test "html unsafe titles in template" do
    title "Test &rarr; Test"

    assert_equal_segment %{<title>Test &amp;rarr; Test - My Site</title>},
                 metamagic(title: ":title - :site", site: "My Site")
  end

  test "html safe title template" do
    title "Test Title"

    assert_equal_segment %{<title>Test Title &rarr; My Site</title>},
                 metamagic(title: ":title &rarr; :site".html_safe, site: "My Site")
  end

  test "html unsafe title template" do
    title "Test Title"

    assert_equal_segment %{<title>Test Title &amp;rarr; My Site</title>},
                 metamagic(title: ":title &rarr; :site", site: "My Site")
  end

  test "deprecated title_template option" do
    title "Test Title"

    assert_equal_segment %{<title>Test Title - My Site</title>},
                 metamagic(site: "My Site", title_template: ":title - :site")
  end
end
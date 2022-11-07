require 'test_helper'

class DataAttributeTest < ActionView::TestCase
  include Metamagic::ViewHelper

  test "title" do
    meta title: {
      value: "Test Title",
      data: { "test-attr" => "title" }
    }

    assert_equal_segment %{<title data-test-attr="title">Test Title</title>},
                 metamagic
  end

  test "title with multiple data attrs" do
    meta title: {
      value: "Test Title",
      data: { "test-attr-1" => "one", "test-attr-2" => "two" }
    }

    assert_equal_segment %{<title data-test-1="one" data-test-2="two">Test Title</title>},
                 metamagic
  end

  test "title with data attr api and no data attribute specified" do
    meta title: { value: "Test Title" }

    assert_equal_segment %{<title>Test Title</title>},
                 metamagic
  end

  test "link rel with data attr" do
    meta rel: {
      author: {
        value: "http://test.com/author.html",
        data: { "test-attr" => "test" }
      }
    }
    rel publisher: {
      value: "http://test.com/publisher.html",
      data: { "test-attr" => "test" }
    }

    assert_equal_segment %{<link href="http://test.com/author.html" rel="author" data-test-attr="test"/>\n<link href="http://test.com/publisher.html" rel="publisher" data-test-attr="test"/>},
                 metamagic
  end

  test "twitter tag with data attribute" do
    meta title: "Test Title",
         twitter: {
           card: {
            value: :summary,
            data: { "test-attr" => "test" }
           }
         }
    twitter site: {
      value: "@flickr",
      data: { "test-attr" => "test" }
    }

    assert_equal_segment %{<title>Test Title</title>\n<meta content="summary" name="twitter:card" data-test-attr="test" />\n<meta content="@flickr" name="twitter:site" data-test-attr="test" />},
                 metamagic
  end

  test "meta tags with data attr" do
    meta keywords: {
           value: %w{one two three},
           data: { "test-attr" => "test" }
         },
         description: {
           value: "My description",
           data: { "test-attr" => "test" }
         }

    assert_equal_segment %{<meta content="one, two, three" name="keywords" data-test-attr="test" />\n<meta content="My description" name="description" data-test-attr="test" />},
                 metamagic
  end

  test "open graph tags with data attr" do
    meta og: {
           image: {
             url: {
               value: "http://test.com/image.jpg",
               data: { "test-attr" => "test" }
             }
           }
         }

    assert_equal_segment %{<meta content="http://test.com/image.jpg" property="og:image:url" data-test-attr="test" />},
                 metamagic
  end

  test "custom tags with data attr" do
    Metamagic::Renderer.register_tag_type :custom, ->(key, value, data) { tag(:custom_tag, one: key, two: value, data: data) }

    meta title: "Test Title",
         custom: {
           first: {
             value: "This is the first",
             data: { "test-attr" => "test" }
           },
           second: {
             value: "This is the second",
             data: { "test-attr" => "test" }
           }
         }

    assert_equal %{<title>Test Title</title>\n<custom_tag one="custom:first" two="This is the first" data-test-attr="test" />\n<custom_tag one="custom:second" two="This is the second" data-test-attr="test" />},
                 metamagic
  end
end

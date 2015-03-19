require 'test_helper'

class HashFromXmlTest < ActionView::TestCase

  test "from xml exmpty " do
    xml = ''
    assert_equal Hash.from_xml(xml),  {}
  end

  test "from xml 1 level " do
    xml = '<meta name="description" content="description_text">'
    assert_equal Hash.from_xml(xml),  { meta: { attributes: { name: "description", content: "description_text" } } }
  end

  test "from xml 2 level s" do
    xml = '<div><span id="span1"></span><span id="span2"></span></div>'
    assert_equal Hash.from_xml(xml),  { div: { span: [ { attributes: { id: "span1" } }, 
                                                       { attributes: { id: "span2" } } ] } }
  end

end
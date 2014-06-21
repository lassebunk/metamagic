module Metamagic
  class TitleTag < Tag
    def to_html
      content_tag(:title, value)
    end
  end
end
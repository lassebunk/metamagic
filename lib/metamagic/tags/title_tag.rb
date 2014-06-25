module Metamagic
  class TitleTag < Tag
    def to_html
      content_tag(:title, value) if value
    end

    def sort_order
      1
    end
  end
end
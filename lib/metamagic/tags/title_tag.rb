module Metamagic
  class TitleTag < Tag
    def to_html
      values = interpolated_values.map(&:value).join(separator).html_safe

      content_tag(:title, values) if values.length > 0
    end

    def sort_order
      1
    end
  end
end

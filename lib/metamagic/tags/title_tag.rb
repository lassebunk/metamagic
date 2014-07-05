module Metamagic
  class TitleTag < Tag
    def to_html
      content_tag(:title, interpolated_values.join(separator).html_safe) if interpolated_values.any?
    end

    def sort_order
      1
    end
  end
end
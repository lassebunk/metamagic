module Metamagic
  class PropertyTag < Tag
    def to_html
      interpolated_values.map { |value| tag(:meta, property: key, content: value) }.join("\n").html_safe.presence
    end

    def sort_order
      3
    end
  end
end
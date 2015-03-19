module Metamagic
  class PropertyTag < Tag
    def to_html
      interpolated_values.map { |value| tag(:meta, property_key => key, content_key => value) }.join("\n").html_safe.presence
    end

    def sort_order
      3
    end

    def property_key
      :property
    end

    def content_key
      :content
    end
  end
end
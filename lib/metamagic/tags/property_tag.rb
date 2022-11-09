module Metamagic
  class PropertyTag < Tag
    def to_html
      interpolated_values.map do |value|
        options = {
          property: key,
          content: value.value,
          data: value.data
        }.compact

        tag(:meta, **options)
      end
        .join("\n")
        .html_safe
        .presence
    end

    def sort_order
      3
    end
  end
end

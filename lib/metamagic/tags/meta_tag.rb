module Metamagic
  class MetaTag < Tag
    def to_html
      return if interpolated_values.empty?

      options = {
        name: key,
        content: interpolated_values.map(&:value).join(", ").html_safe,
        data: interpolated_values.first.data
      }.compact

      tag(:meta, **options)
    end

    def sort_order
      2
    end

    def remove_prefix?
      false
    end
  end
end

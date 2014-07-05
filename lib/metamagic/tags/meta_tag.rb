module Metamagic
  class MetaTag < Tag
    def to_html
      return if interpolated_values.empty?
      tag(:meta, name: key, content: interpolated_values.join(", ").html_safe)
    end

    def sort_order
      2
    end

    def remove_prefix?
      false
    end
  end
end
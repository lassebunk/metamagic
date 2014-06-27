module Metamagic
  class MetaTag < Tag
    def to_html
      return unless values = Array(value).compact.presence
      tag(:meta, name: key, content: values.join(", "))
    end

    def sort_order
      2
    end

    def remove_prefix?
      false
    end
  end
end
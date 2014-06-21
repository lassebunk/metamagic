module Metamagic
  class PropertyTag < Tag
    def to_html
      Array(value).map { |value| tag(:meta, property: key, content: value) }.join("\n").html_safe
    end
  end
end
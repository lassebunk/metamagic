module Metamagic
  class MetaTag < Tag
    def to_html
      tag(:meta, name: key, content: Array(value).join(", "))
    end
  end
end
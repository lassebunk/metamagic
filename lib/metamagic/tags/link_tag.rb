module Metamagic
  class LinkTag < Tag
    def to_html
      tag(:link, rel: key, href: value)
    end
  end
end
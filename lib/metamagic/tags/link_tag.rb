module Metamagic
  class LinkTag < Tag
    def to_html
      interpolated_values.map { |value| tag(:link, rel: key, href: value) }.join("\n").html_safe.presence
    end
  end
end
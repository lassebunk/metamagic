module Metamagic
  class LinkTag < Tag
    def to_html
      interpolated_values.map do |value|
        options = {
          rel: key,
          href: value.value,
          data: value.data
        }.compact

        tag(:link, **options)
      end
        .join("\n")
        .html_safe
        .presence
    end
  end
end

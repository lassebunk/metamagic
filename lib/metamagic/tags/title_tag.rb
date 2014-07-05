module Metamagic
  class TitleTag < Tag
    def to_html
      interpolated_title = if title_template.is_a?(Proc)
        instance_exec(&title_template)
      else
        title_template.gsub(/:\w+/) do |key|
          if key == ":title"
            value
          else
            send(key[1..-1])
          end
        end
      end
      content_tag(:title, interpolated_title) if interpolated_title.present?
    end

    def title
      value
    end

    def sort_order
      1
    end
  end
end
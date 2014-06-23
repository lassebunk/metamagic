module Metamagic
  class PropertyTag < Tag
    def initialize(context, key, value)
      super
      @key = @key.gsub /^property:/, "" # If added via property helper
    end

    def to_html
      Array(value).map { |value| tag(:meta, property: key, content: value) }.join("\n").html_safe
    end

    def sort_order
      3
    end
  end
end
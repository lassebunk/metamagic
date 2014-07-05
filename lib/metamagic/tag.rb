module Metamagic
  class Tag
    attr_reader :context, :key, :value

    def initialize(context, key, value)
      @context, @key, @value = context, key.to_s, value
      @key = @key.gsub /^[^:]+:/, "" if remove_prefix?
    end

    def to_html
      raise "#{self.class.name}#to_html must be overridden to render tag"
    end

    def sort_order
      1000
    end

    def remove_prefix?
      true
    end

    def template
      @template ||= template_for(key) || :value
    end

    def interpolated_values
      @interpolated_values ||= Array(template).map do |template|
        case template
        when Proc
          instance_exec(&template)
        when Symbol
          send(template)
        when String
          ERB::Util.html_escape(template).gsub(/:\w+/) do |key|
            ERB::Util.html_escape(send(key[1..-1]))
          end.html_safe
        else
          raise "Unknown template type #{template.class}."
        end
      end.flatten.compact.uniq.map { |value| ERB::Util.html_escape(value) }
    end

    def ==(other)
      self.class == other.class && self.key == other.key
    end

    def <=>(other)
      [sort_order, self.class.name] <=> [other.sort_order, other.class.name]
    end

    def method_missing(method, *args, &block)
      return value if method.to_s == key.gsub(":", "_") # When calling e.g. `og_image`. Used for interpolating values.
      context.send(method, *args, &block)
    end
  end
end
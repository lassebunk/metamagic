module Metamagic
  class Tag
    attr_reader :context, :key, :value

    def initialize(context, key, value)
      @context, @key, @value = context, key, value
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

    def ==(other)
      self.class == other.class && self.key == other.key
    end

    def <=>(other)
      [sort_order, self.class.name] <=> [other.sort_order, other.class.name]
    end

    def method_missing(*args)
      context.send(*args)
    end
  end
end
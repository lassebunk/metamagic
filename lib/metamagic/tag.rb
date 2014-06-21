module Metamagic
  class Tag
    attr_reader :context, :key, :value

    def initialize(context, key, value)
      @context, @key, @value = context, key, value
    end

    def to_html
      raise "#{self.class.name}#to_html must be overridden to render tag"
    end

    def method_missing(*args)
      context.send(*args)
    end
  end
end
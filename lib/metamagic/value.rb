module Metamagic
  class Value
    def self.create_escaped(value)
      value.is_a?(Hash) ? ValueHash.new(value) : ValueString.new(value)
    end

    def escape(string)
      ERB::Util.html_escape(string)
    end
  end

  class ValueString < Value
    attr_reader :value
    def initialize(value)
      @value = escape(value)
    end

    def data
      nil
    end
  end

  class ValueHash < Value
    attr_reader :value_hash
    def initialize(value_hash)
      @value_hash = value_hash
      @value_hash[:value] = if value.is_a?(Array)
                              value.map { |v| escape(v) }
                            else
                              escape(value)
                            end

      if @value_hash.key?(:data)
        @value_hash[:data] = data.map { |k, v| [escape(k), escape(v)] }.to_h
      end
    end

    def value
      value_hash[:value]
    end

    def data
      value_hash[:data]
    end
  end
end

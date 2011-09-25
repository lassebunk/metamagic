module Metamagic
  module HelperMethods
    def meta(options = {})
      @meta_tags = options
    end

    def metamagic(options = {})
      options = @meta_tags || options

      out = ''
      options.each do |key, value|
        if value.is_a?(Array)
          value = value.join(", ")
        end
        out += tag('meta', :name => key.to_s, :content => value) if value
      end
      
      out.html_safe
    end
  end
end
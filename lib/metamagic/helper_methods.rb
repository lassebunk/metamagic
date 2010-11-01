module Metamagic
  module HelperMethods
    def meta(options = {})
      @meta_tags = options
    end

    def metamagic(options = {})
      options = @meta_tags || options

      out = ''
      options.each do |key, value|
        out += tag('meta', :name => key.to_s, :content => value) if value
      end
      
      out.html_safe
    end
    
    def self.included(base)
      base.send :helper_method, :meta, :metamagic
    end
  end
end
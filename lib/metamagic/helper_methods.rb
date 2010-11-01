module Metamagic
  module HelperMethods
    def meta(options = {})
      @_metamagic = options
    end

    def metamagic(options = {})
      options = @_metamagic || options

      out = ''
      options.each do |key, value|
        out += tag('meta', :name => key.to_s, :content => value)
      end
      
      out.html_safe
    end
    
    def self.included(base)
      base.send :helper_method, :meta, :metamagic
    end
  end
end
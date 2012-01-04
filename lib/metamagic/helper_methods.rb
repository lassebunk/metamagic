module Metamagic
  module HelperMethods
    def meta(options = {})
      @meta_tags = options
    end

    def metamagic(options = {})
      options = @meta_tags || options

      out = ''
      options.each do |key, value|
        props = { :name => key.to_s }
        
        if value.is_a?(Hash)
          props.merge! value
        else
          props[:content] = value
        end
        
        # loop through each property to find
        # arrays that need to be joined
        props.each_pair do |propkey, propvalue|
          if propvalue.is_a?(Array)
            propvalue = propvalue.join(", ")
          end
          props[propkey] = propvalue
        end
        
        out += tag('meta', props) if value
      end
      
      out.html_safe
    end
  end
end
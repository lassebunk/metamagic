module Metamagic
  module HelperMethods
    def meta_tags
      @meta_tags ||= []
    end
    
    def meta(*options)
      # add page specific meta tags
      add_meta_tags options
    end
    
    def add_tag_if_not_existing(new_tag)
      # add meta tag if it's not existing
      unless meta_tags.find { |tag| tag[:name] && new_tag[:name] && tag[:name] == new_tag[:name] }
        meta_tags << new_tag
      end
    end
    
    def add_meta_tags(options)
      options.each do |option|
        if option.is_a?(Hash)
          option.each_pair do |key, value|
            add_tag_if_not_existing :name => key, :content => value
          end
        elsif option.is_a?(Array)
          option.each do |tag|
            add_tag_if_not_existing tag
          end
        else
          raise TypeError, "Unknown tag type #{tag.class.name}. Use either Hash or Array."
        end
      end
    end

    def metamagic(*options)
      # apply default meta tags if they don't exist
      add_meta_tags options
      
      # loop through the added tags
      out = []
      meta_tags.each do |tag|
        if tag[:name] == :title
          out << content_tag(:title, tag[:content])
        else
          out << tag(:meta, tag)
        end
      end
      
      # return tags
      out.join.html_safe
    end
  end
end
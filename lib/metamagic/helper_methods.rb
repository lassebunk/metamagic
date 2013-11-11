module Metamagic
  module HelperMethods
    def meta_tags
      @meta_tags ||= []
    end

    def meta(*options)
      # add page specific meta tags
      add_meta_tags options
    end

    def add_tag_if_not_existing_or_insert_defaults(new_tag)
      # Look for existing tag name
      existing_name_tag = meta_tags.find { |tag| tag[:name] && new_tag[:name] && tag[:name] == new_tag[:name] }
      if existing_name_tag
        # Replace [defaults] with existing content
        return existing_name_tag[:content] = existing_name_tag[:content].sub('[defaults]', new_tag[:content])
      end
      # Look for existing tag property
      existing_property_tag = meta_tags.find { |tag| tag[:property] && new_tag[:property] && tag[:property] == new_tag[:property] }
      if existing_property_tag
        # Replace [defaults] with existing content
        return existing_property_tag[:content] = existing_property_tag[:content].sub('[defaults]', new_tag[:content])
      end
      # add meta tag if there's not an existing one with the same name or property attribute
      meta_tags << new_tag
    end

    def add_meta_tags(options)
      options.each do |option|
        if option.is_a?(Hash)
          option.each_pair do |key, value|
            if value.is_a?(Array)
              add_tag_if_not_existing_or_insert_defaults :name => key, :content => value.join(", ")
            else
              add_tag_if_not_existing_or_insert_defaults :name => key, :content => value
            end
          end
        elsif option.is_a?(Array)
          option.each do |tag|
            add_tag_if_not_existing_or_insert_defaults tag
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
          # add tag
          out << tag(:meta, tag)
        end
      end

      # return tags
      out.join("\n").html_safe
    end

    def metappend(*options)

    end
  end
end
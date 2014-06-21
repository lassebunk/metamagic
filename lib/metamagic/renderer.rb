module Metamagic
  class Renderer
    DEFAULT_TAG_TYPES = {
      title:   TitleTag,
      og:      PropertyTag,
      twitter: PropertyTag
    }

    class << self
      def tag_types
        @tag_types ||= DEFAULT_TAG_TYPES.dup
      end

      def register_tag_type(prefix, klass)
        tag_types[prefix.to_sym] = klass
      end

      def tag_type_for_key(key)
        prefix = key.split(":").first
        tag_types[prefix.to_sym] || MetaTag
      end
    end

    attr_reader :context

    def initialize(context)
      @context = context
    end

    def tags
      @tags ||= []
    end

    def add(hash = {})
      transform_hash(hash).each do |k, v|
        klass = self.class.tag_type_for_key(k)
        next if tags.any? { |t| t.class == klass && t.key == k }
        tags << if klass.is_a?(Proc)
          CustomTag.new(self, k, v, klass)
        else
          klass.new(self, k, v)
        end
      end
    end

    def render
      tags.map(&:to_html).join("\n").html_safe
    end

    def method_missing(*args)
      context.send(*args)
    end

    private

    # Transforms a nested hash into meta property keys.
    def transform_hash(hash, path = "")
      hash.each_with_object({}) do |(k, v), ret|
        key = path + k.to_s

        if v.is_a?(Hash)
          ret.merge! transform_hash(v, "#{key}:")
        else
          ret[key] = v
        end
      end
    end
  end
end
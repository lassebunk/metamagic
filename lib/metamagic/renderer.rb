module Metamagic
  class Renderer
    DEFAULT_TAG_TYPES = {
      title:       TitleTag,
      description: MetaTag,
      keywords:    MetaTag,
      property:    PropertyTag,
      rel:         LinkTag,
      og:          OpenGraphTag,
      twitter:     TwitterTag
    }

    DEFAULT_SEPARATOR = " - "

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

    def add(hash = {}, enable_templates = false)
      raise ArgumentError, "Defining meta properties via arrays has been removed in Metamagic v3.0 and replaced by some pretty helpers. Please see the readme at https://github.com/lassebunk/metamagic for more info." if hash.is_a?(Array)

      transform_hash(hash).each do |key, value|
        if enable_templates && is_template?(value)
          add_template key, value
          value = nil
        end

        klass = self.class.tag_type_for_key(key)
        tag = if klass.is_a?(Proc)
          CustomTag.new(self, key, value, klass)
        else
          klass.new(self, key, value)
        end
        tags << tag unless tags.include?(tag)
      end
    end

    def templates
      @templates ||= {}
    end

    def add_template(key, value)
      templates[key] = value
    end

    def template_for(key)
      templates[key]
    end

    def has_tag_type?(prefix)
      self.class.tag_types.has_key?(prefix)
    end

    def title_template
      @title_template ||= ":title"
    end

    attr_writer :title_template

    def site
      @site or raise "Metamagic site not set. Please use `metamagic site: 'My Site'` to set it."
    end

    attr_writer :site

    def separator
      @separator ||= DEFAULT_SEPARATOR
    end

    attr_writer :separator

    def render
      tags.sort.map(&:to_html).compact.join("\n").html_safe
    end

    def method_missing(*args)
      context.send(*args)
    end

    private

    def is_template?(value)
      Array(value).any? do |val|
        val.is_a?(Proc) ||
        val.is_a?(Symbol) ||
        val =~ /\A:\w+/
      end
    end

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
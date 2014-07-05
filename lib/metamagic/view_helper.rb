module Metamagic
  module ViewHelper
    def meta(hash = {})
      metamagic_renderer.add hash
    end

    def metamagic(hash = {})
      if title_template = hash.delete(:title_template)
        # Deprecation warning
        Rails.logger.warn "[Metamagic] Using `metamagic title_template: #{title_template.inspect}` has been deprecated. Please use `metamagic title: #{title_template.inspect}` instead."
        hash[:title] = title_template
      end

      # Loop through special options
      hash.slice(:site, :separator).each do |key, value|
        metamagic_renderer.send("#{key}=", value)
        hash.delete key
      end

      metamagic_renderer.add hash, true
      metamagic_renderer.render
    end

    def method_missing(method, *args, &block)
      if metamagic_renderer.has_tag_type?(method)
        args.first.tap do |value|
          meta method => value
        end
      else
        super
      end
    end

    private

    def metamagic_renderer
      @metamagic_renderer ||= Renderer.new(self)
    end
  end
end
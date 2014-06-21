module Metamagic
  module ViewHelper
    def meta(hash = {})
      metamagic_renderer.add hash
    end

    def metamagic(hash = {})
      metamagic_renderer.add hash
      metamagic_renderer.render
    end

    def method_missing(method, *args, &block)
      if metamagic_renderer.has_tag_type?(method)
        meta method => args.first
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
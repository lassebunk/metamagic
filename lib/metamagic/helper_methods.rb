module Metamagic
  module HelperMethods
    def meta(hash = {})
      metamagic_renderer.add hash
    end

    def metamagic(hash = {})
      metamagic_renderer.add hash
      metamagic_renderer.render
    end

    private

    def metamagic_renderer
      @metamagic_renderer ||= Renderer.new(self)
    end
  end
end
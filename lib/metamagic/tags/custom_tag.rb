module Metamagic
  class CustomTag < Tag
    attr_reader :render_proc

    def initialize(context, key, value, render_proc)
      super(context, key, value)
      @render_proc = render_proc
    end

    def to_html
      instance_exec key, value, &render_proc
    end
  end
end
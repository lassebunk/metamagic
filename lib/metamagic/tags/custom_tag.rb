module Metamagic
  class CustomTag < Tag
    attr_reader :render_proc

    def initialize(context, key, value, render_proc)
      super(context, key, value)
      @render_proc = render_proc
    end

    def remove_prefix?
      false
    end

    def to_html
      instance_exec key, interpolated_values, &render_proc
    end
  end
end
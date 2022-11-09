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
      if render_proc.arity == 2
        instance_exec(
          key,
          interpolated_values.map(&:value),
          &render_proc
        )
      else
        instance_exec(
          key,
          interpolated_values.map(&:value),
          interpolated_values.first.data,
          &render_proc
        )
      end
    end
  end
end

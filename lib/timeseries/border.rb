module TimeSeries
  class Border < Layer
    
    def initialize opts={}
      super(opts)
      @series = []
    end
    
    def thickness
    end
    
    def draw ctx
      ctx.set_antialias(Cairo::ANTIALIAS_NONE)
      ctx.stroke_preserve
      ctx.set_source_color(color)
      ctx.move_to(0, 0)
      ctx.line_to(width, 0)
      ctx.line_to(width, height)
      ctx.line_to(0, height)
      ctx.line_to(0, 0)
      ctx.stroke
    end
    
  end
end
module TimeSeries
  class Series < Layer
  
    def initialize name, points, opts={}
      super(opts)
      @name = name
      @points = points
    end
    
    def draw ctx
      ctx.set_source_color(color)
      ctx.stroke_preserve 
      ctx.move_to(*@points.first)
      @points.each do |point|
        ctx.line_to(*point)
      end
      ctx.stroke
    end
  
  end
end
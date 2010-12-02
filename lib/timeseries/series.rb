module TimeSeries
  class Series < Layer
  
    attr_accessor :name
  
    def initialize name, points, opts={}
      super(opts)
      self.name = name
      @points = points
    end
    
    def name
      @opts[:name]
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
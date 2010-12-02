module TimeSeries
  class Timespan < Layer
      
    def initialize from, to, text, opts={}
      super(opts)
      @from = from
      @to = to
      @text = text
    end
  
    def draw ctx
    
      x1 = calculate_x(@from)
      x2 = calculate_x(@to)
    
      ctx.fill_preserve
      ctx.set_source_color(color)
      ctx.rectangle(x1, 0, x2 - x1, height)
      ctx.fill
    
      if @text
        draw_layer Text.new(@text, :x => x2 - ((x2 - x1) / 2), :y => 10, :align => :center), ctx
      end
    
    end
  
  end
end
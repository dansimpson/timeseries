module TimeSeries
  
  class LegendItem
  
    def initialize text, color
      @text  = text
      @color = color
    end
    
    def draw ctx
      
      Text.new(@text, :x => 10)
      
    end
  
  end
  
  
  class Legend < Layer
    
    def initialize opts={}
      super(opts)
      @series = []
    end
    
    def position
    end
    
    def draw ctx
      
      w = 100
      h = 200

      ctx.set_source_color(0xFF000099)
      ctx.rectangle(width - w - 20, height - h - 20, width - w, height - h)
      ctx.fill
    end
    
    def add_series series
      @series << series
    end
    
  end
end
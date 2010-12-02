module TimeSeries
    
  class Legend < Layer
    
    def initialize opts={}
      super(opts)
      @series = []
    end
    
    def position
    end
    
    def draw ctx
      
      w = 100
      h = 100
      m = 10
      
      p = 5
      require "pp"
      @series.each do |series|
        #pp series
        #series[:text]
      end

      ctx.fill_preserve
      ctx.translate(width - w - m, height - h - m)
      ctx.set_source_color(0x00000099)
      ctx.rectangle(0, 0, w, h)
      ctx.fill
      
      #@items.each do |item|
        
        
        
        #draw_layer(item, ctx)
      #end
    end
    
    def add_series series
      @series << series
    end
    
  end
end
module TimeSeries
  class Layer
    
    def initialize opts={}
      @opts = opts
      @defaults = {}
    end
    
    def draw ctx
      raise "Can't draw an abstract layer"
    end
    
    def height
      @opts[:height]
    end
    
    def width
      @opts[:width]
    end
    
    def color
      @opts[:color] || 0x000000FF
    end
    
    def x
      @opts[:x] || 0
    end
    
    def y
      @opts[:y] || 0
    end
    
    def min_time
      @opts[:min_time] || 0
    end
    
    def max_time
      @opts[:max_time] || width
    end
    
    def duration
      max_time.to_i - min_time.to_i
    end
    
    def min
      @opts[:min] || 0
    end
    
    def max
      @opts[:max] || height
    end
    
    def merge other={}
      @opts.merge!(other) if other
    end
    
    def calculate_x time
      ((time.to_i - min_time.to_i) / duration.to_f) * width
    end
    
    def calculate_y value
      ((time.to_f - min_time.to_f) / duration) * width
    end
    
    def calculate_value y
      ((time.to_f - min_time.to_f) / duration) * width
    end
    
    def calculate_time x
      min_time + ((x.to_f / width) * duration)
    end
    
    def draw_layer layer, ctx
      ctx.save
      layer.merge(@opts)
      layer.draw ctx
      ctx.restore
    end
    
  end
end
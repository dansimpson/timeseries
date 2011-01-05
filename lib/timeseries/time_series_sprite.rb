module TimeSeries
  class TimeSeriesSprite < Sprite

    attr_accessor :min_time, :max_time
    attr_accessor :min_value, :max_value

    def initialize opts={}, &block
      super
      self.min_time = opts[:min_time]
      self.max_time = opts[:max_time]
      self.min_value = opts[:min_value]
      self.max_value = opts[:max_value]
    end
    
    def calculate_x time
      ((time.to_f - min_time.to_f) / duration) * width
    end
    
    def calculate_y value
      height - (((value - min_value.to_f) / range) * height)
    end
    
    def calculate_value y
      ((time.to_f - min_time.to_f) / duration) * width
    end
    
    def calculate_time x
      min_time + ((x.to_f / width) * duration)
    end
    
    def duration
      max_time.to_f - min_time.to_f
    end
    
    def range
      max_value - min_value
    end
    
  end
end
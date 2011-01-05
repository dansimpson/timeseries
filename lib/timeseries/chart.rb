module TimeSeries
  class Chart < TimeSeriesSprite

    attr_accessor :context, :legend, :background, :title
    
    def initialize opts={}
      
      super
      
      self.min_time = nil
      self.max_time = nil
      self.legend = TimeSeries::Legend.new(:padding => 4, :font_size => 14, :font_color => 0xDDDDDDFF)
      self.context = Cairo::Context.new(Cairo::ImageSurface.new(width, height))
      
      context.scale(1,1)
      
      add Grid.new
      
      on_render do |ctx|
        
        add title
        add legend
        children.each do |child|
          if child.kind_of? TimeSeriesSprite
            child.min_time = min_time
            child.max_time = max_time
            child.max_value = max_value
            child.min_value = min_value
          end
        end
        
        add Border.new(
          :color => 0xAAAAAAFF
        )
      end
    end

  
    def render_to file, type=:png
      render context
      case type
      when :pdf
      when :svg
      else
        context.target.write_to_png(file)
      end
    end
    
    def add_series name, data, opts={}
      
      data.each do |r|
        self.min_time = min_time ? [min_time, r[0]].min : r[0]
        self.max_time = max_time ? [max_time, r[0]].max : r[0]
        self.min_value = min_value ? [min_value, r[1]].min : r[1]
        self.max_value = max_value ? [max_value, r[1]].max : r[1]
      end

      s = Series.new(name, data, opts)
      
      add s
      legend.add_series s
    end
    
    
    def set_title text="Chart", color=0x444444FF, size=14
      self.title = TextSprite.new({
        :x => (width / 2) - padding, 
        :align => :center, 
        :y => -padding / 2,
        :valign => :middle,
        :size => size,
        :color => color,
        :text => text,
        :face => "Arial"
      })      
    end
    
    def add_timespan from, to, text=nil, color=0x00000044
      add Timespan.new(from, to, text, :color => color)
    end
    
    def add_annotation time, text=""
      add Annotation.new time, text
    end
    
  end
end
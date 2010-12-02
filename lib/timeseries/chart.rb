module TimeSeries
  class Chart

    attr_accessor :context, :layers, :legend
    attr_accessor :width, :height, :padding
    
    def initialize opts={}
      
      self.layers = []
      self.width = opts[:width] || 800
      self.height = opts[:height] || 400
      self.padding = opts[:padding] || 20
      self.legend = TimeSeries::Legend.new
      self.context = Cairo::Context.new(Cairo::ImageSurface.new(width, height))
      context.set_line_join(Cairo::LINE_JOIN_ROUND)
      context.set_line_cap(Cairo::LINE_CAP_ROUND)
      context.set_line_width(1)
      context.scale(1,1)
      context.select_font_face("Arial")      
      context.translate(padding, padding)

      layers << Grid.new
    end

  
    def render file
      
      layers << legend
      
      layers.each do |layer|
        context.save

        layer.merge({
          :height => height - (padding * 2),
          :width => width - (padding * 2),
          :min => -250,
          :max => 100,
          :min_time => Time.now - (7 * 24 * 60 * 60),
          :max_time => Time.now
        })

        layer.draw(context)
        context.restore
      end
      
      [60, 64, 200, 203, 207, 500].each do |x|
        Annotation.new(
          :x => x,
          :height => height - 2 * padding,
          :background => 0x000000FF
        ).render context
      end

      context.target.write_to_png(file)

    end
    
  
    def normalize points
      x1 = points.first[0].to_f
      x2 = points.last[0].to_f
      
      points.collect { |p|
        [((p[0].to_f - x1) / (x2 - x1)) * (width - (padding * 2)), p[1]]
      }
    end
    
    def add_series name, data, opts={}
      s = Series.new(name, normalize(data), opts)
      layers << s
      legend.add_series s
    end
    
    # check it
    def add_layer layer
      layers << layer
    end
    
    def set_title text="Chart", color=0x444444FF, size=14
      puts width
      add_layer Text.new(text, {
        :x => (width / 2) - padding, 
        :align => :center, 
        :y => -padding / 2,
        :valign => :middle,
        :font_size => size,
        :color => color
      })
    end
    
    def add_timespan from, to, text=nil, color=0x00000033
      add_layer Timespan.new(from, to, text, :color => color)
    end
    
  end
end
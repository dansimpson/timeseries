module TimeSeries
  class Chart

    def initialize opts={}
      @layers = []
      @width = opts[:width] || 800
      @height = opts[:height] || 400
      @padding = opts[:padding] || 20
      
      @ctx = Cairo::Context.new(Cairo::ImageSurface.new(@width, @height))
      @ctx.set_line_join(Cairo::LINE_JOIN_ROUND)
      @ctx.set_line_cap(Cairo::LINE_CAP_ROUND)
      @ctx.set_line_width(1)
      @ctx.scale(1,1)
      @ctx.select_font_face("Arial")      
      @ctx.translate(@padding, @padding)

      @layers << Grid.new

    end

  
    def render file
      
      @layers.each do |layer|
        @ctx.save

        layer.merge({
          :height => @height - (@padding * 2),
          :width => @width - (@padding * 2),
          :min => -250,
          :max => 100,
          :min_time => Time.now - (7 * 24 * 60 * 60),
          :max_time => Time.now
        })
        
        layer.draw(@ctx)
        @ctx.restore
      end
      
      # compute mins, maxes, etc
      
      @ctx.target.write_to_png(file)
    end
    
  
    def normalize points
      x1 = points.first[0].to_f
      x2 = points.last[0].to_f
      
      points.collect { |p|
        [((p[0].to_f - x1) / (x2 - x1)) * (@width - (@padding * 2)), p[1]]
      }
    end
    
    def add_series name, data, opts={}
      @layers << Series.new(name, normalize(data), opts)
      #@ctx.set_source_rgba(opts[:color]) if opts[:color]
     
      #pts = normalize(points)

    end
    
    # check it
    def add_layer layer
      @layers << layer
    end
    
    def set_title text="Chart", color=0x444444FF, size=14
      add_layer Text.new(text, {
        :x => (@width / 2) - @padding, 
        :align => :center, 
        :y => -@padding / 2,
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
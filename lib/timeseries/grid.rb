module TimeSeries
  class Grid < Layer
  
    def initialize opts={}
      super(opts)
    end

    def tick_length
      @opts[:tick_length] || 0
    end
    
    def horizontal_tick_length
      @opts[:horizontal_tick_length] || tick_length
    end

    def vertical_tick_length
      @opts[:vertical_tick_length] || tick_length
    end
    
    def num_horizontal
      @opts[:num_horizontal] || 10
    end
    
    def num_vertical
      @opts[:num_vertical] || 12
    end
    
    def label_color
      @opts[:label_color] || 0x888888FF
    end
          
    def draw ctx
      
      # disable anti-alias for smooth lines        
      ctx.set_antialias(Cairo::ANTIALIAS_NONE)
      ctx.stroke_preserve

      draw_lines ctx
      draw_labels ctx

      #draw the border
      ctx.set_source_color(0xAAAAAAFF)
      ctx.move_to(0, 0)
      ctx.line_to(width, 0)
      ctx.line_to(width, height)
      ctx.line_to(0, height)
      ctx.line_to(0, 0)
      ctx.stroke
      
    end
    
    def draw_lines ctx
      ctx.save
      ctx.set_dash([8,2])
      ctx.set_source_color(0xCCCCCCFF)
      
      # num = 9
      # 1.upto(num) do |idx|
      #   x = idx * (width / num)
      #   y = idx * (height / num)
      #   ctx.move_to(x, y)
      #   ctx.line_to(-x, y)
      #   ctx.line_to(width, y)
      #   ctx.line_to(x, -y)
      #   ctx.line_to(x, height)
      # end
      
      num_horizontal.times do |idx|
        y = idx * (height / num_horizontal)
        ctx.move_to(-horizontal_tick_length, y)
        ctx.line_to(width, y)
      end
      
      num_vertical.times do |idx|
        x = idx * (width / num_vertical)
        ctx.move_to(x, 0)
        ctx.line_to(x, height + vertical_tick_length)
      end
      
      ctx.stroke
      ctx.restore
    end
    
    def draw_labels ctx

      vinc = (max_time - min_time) / num_vertical
      hinc = (max - min) / num_horizontal

      0.upto(num_horizontal) do |idx|
          text = (min + (hinc * (num_horizontal - idx))).round.to_s
          y = idx * (height / num_horizontal)
          draw_layer Text.new(text, {
            :align => :right,
            :y => y,
            :x => -8,
            :color => label_color
          }), ctx
      end
      
      1.upto(num_vertical - 1) do |idx|
        x = idx * (width / num_vertical)
        draw_layer Text.new(calculate_time(x).strftime("%m/%d"), {
          :align => :center,
          :valign => :top,
          :y => height + vertical_tick_length + 4,
          :x => x,
          :rotate => Math::PI / 20,
          :color => label_color
        }), ctx
        
      end      
    end
          
  
  end
end
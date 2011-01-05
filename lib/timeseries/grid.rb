module TimeSeries
  class Grid < TimeSeriesSprite
  
    attr_accessor :tick_length, :horizontal_tick_length, :vertical_tick_length
    attr_accessor :num_horizontal, :num_vertical, :label_color
  
    def initialize opts={}, &block
      super
      
      self.tick_length = opts[:tick_length] || 0
      self.horizontal_tick_length = opts[:horizontal_tick_length] || tick_length
      self.vertical_tick_length = opts[:vertical_tick_length] || tick_length
      self.num_horizontal = opts[:num_horizontal] || 10
      self.num_vertical = opts[:num_vertical] || 12
      self.label_color = opts[:label_color] || 0x888888FF
      

      # add labels and borders
      on_render do |ctx|
        
        vinc = (max_time - min_time) / num_vertical
        hinc = (max_value - min_value) / num_horizontal

        0.upto(num_horizontal) do |idx|
            text = (min_value + (hinc * (num_horizontal - idx))).round.to_s
            y = idx * (height / num_horizontal)
            add TextSprite.new({
              :align => :right,
              :valign => :middle,
              :y => y,
              :x => -8,
              :color => label_color,
              :text => text
            })
        end

        1.upto(num_vertical - 1) do |idx|
          x = idx * (width / num_vertical)
          add TextSprite.new({
            :align => :center,
            :valign => :top,
            :y => height + vertical_tick_length + 4,
            :x => x,
            :rotate => Math::PI / 20,
            :color => label_color,
            :text => calculate_time(x).strftime("%m/%d")
          })
        end
      end
      
      # render grid
      on_render do |ctx|
        ctx.set_antialias(Cairo::ANTIALIAS_NONE)
        ctx.set_line_width(1)
        ctx.stroke_preserve
        ctx.set_dash([8,2])
        ctx.set_source_color(0xCCCCCCFF)

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
      end
  
    end

          
  
  end
end
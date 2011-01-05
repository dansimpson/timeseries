module TimeSeries
  
  class Border < Sprite

    attr_accessor :color

    def initialize opts={}, &block
      super
      
      self.color = opts[:color] || color
      
      on_render do |ctx|
        ctx.set_antialias(Cairo::ANTIALIAS_NONE)
        ctx.stroke_preserve
        ctx.set_source_color(color)
        ctx.move_to(0, 0)
        ctx.line_to(width, 0)
        ctx.line_to(width, height)
        ctx.line_to(0, height)
        ctx.line_to(0, 0)
        ctx.stroke
      end
    end
    
  end
end
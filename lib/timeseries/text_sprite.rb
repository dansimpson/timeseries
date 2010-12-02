

# Just some notes
module TimeSeries

  class TextSprite < Sprite

    attr_accessor :size, :text, :color, :face, :align, :valign, :padding

    def initialize opts={}, &block
      super
      
      self.size = opts[:size] || 12
      self.text = opts[:text] || "Default"
      self.color = opts[:color] || color
      self.face = opts[:face] || "Arial"
      self.align = opts[:align]
      self.valign = opts[:valign]
      self.padding = opts[:padding] || 0
      
      on_render do |ctx|  
        ctx.set_font_size(size)
        ctx.set_source_color(color)
        ctx.select_font_face(face)

        dim = ctx.text_extents(text)

        #offsets
        xoff = case align
        when :center
          -dim.width / 2
        when :right
          -dim.width
        else
          0
        end

        yoff = case valign
        when :middle
          dim.height / 2
        when :top
          dim.height
        else
          0
        end
        
        ctx.move_to(xoff + padding, yoff + padding)
        ctx.show_text(text)
      end

    end
    
  end
    
end
module TimeSeries
  class Text < Layer
    
    def initialize text, opts={}
      super(opts)
      @text = text
    end
    
    def align
      @opts[:align] || :left
    end
    
    def valign
      @opts[:valign] || :middle
    end
    
    def font_size
      @opts[:font_size] || 10
    end
    
    def font_face
      @opts[:font_face] || "Arial"
    end
    
    def rotate
      @opts[:rotate]
    end
    
    def dimensions
      ctx = Cairo::Context.new #(Cairo::ImageSurface.new(width, height))
      ctx.set_font_size(font_size)
      ctx.select_font_face(font_face)
      ctx.text_extents(@text)
    end
    
    def draw ctx
      ctx.set_font_size(font_size)
      ctx.set_source_color(color)
      ctx.select_font_face(font_face)
      
      dim = ctx.text_extents(@text)

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

      #if rotate
      #  ctx.translate(x,y)
      #  ctx.rotate(rotate)
      #end
      
      ctx.move_to(x + xoff, y + yoff)
      ctx.show_text(@text)
    end
    
  end
end
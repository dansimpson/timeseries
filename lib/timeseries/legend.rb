module TimeSeries
    
  class Legend < Sprite
    
    attr_accessor :series, :font_size, :font_face, :font_color, :margin
    
    def initialize opts={}, &block
      super
      
      self.series = []
      self.font_size = opts[:font_size] || 12
      self.font_face = opts[:font_face] || "Arial"
      self.font_color = opts[:font_color] || 0xFFFFFFFF
      self.margin = opts[:margin] || 8
      
      on_render do |ctx|
        
        ctx.set_font_size(font_size)
        ctx.set_source_color(0xFF00FFFF)
        ctx.select_font_face(font_face)

        box_width  = 0
        box_height = padding
        lin_height = 0
        series.each do |s|
          dim = ctx.text_extents(s.name)
          lin_height  = dim.height
          box_height += dim.height + padding
          box_width   = [
            dim.width,
            box_width
          ].max
        end
        
        #account for spacing a color box
        box_width += (padding * 4) + lin_height
        
        ctx.translate(width - box_width - margin, height - box_height - margin)
        
        # rendner background
        ctx.fill_preserve
        ctx.set_source_color(0x000000BB)
        ctx.rectangle(0, 0, box_width, box_height)
        ctx.fill
        
        cur_height = 0
        series.each do |s|
          dim = ctx.text_extents(s.name)
          ctx.set_source_color(s.color)
          ctx.rectangle(padding, padding + cur_height, lin_height, lin_height)
          ctx.fill
          TextSprite.new(
            :x => padding + lin_height + padding,
            :y => cur_height + padding,
            :text => s.name,
            :face => font_face,
            :size => font_size,
            :valign => :top,
            :color => font_color
          ).render(ctx)
          cur_height += padding + dim.height
        end
      end
      
    end
    
    def add_series series
      self.series << series
    end
    
  end
end
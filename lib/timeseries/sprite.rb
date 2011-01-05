

# Just some notes
module TimeSeries

  class Sprite

    #attr_accessor :opts
    attr_accessor :children, :parent, :callbacks
    attr_accessor :x, :y, :width, :height, :position
    attr_accessor :background, :padding

    def initialize opts={}, &block
      self.children = []
      self.callbacks = block ? [block] : []
      self.x = opts[:x] || 0
      self.y = opts[:y] || 0
      self.width = opts[:width] || 0
      self.height = opts[:height] || 0
      self.position = opts[:position] || :relative
      self.background = opts[:background]
      self.padding = opts[:padding] || 0
    end
    
    def offset_x
      return x if position == :absolute || parent == nil
      x + parent.offset_x
    end
    
    def offset_y
      return y if position == :absolute || parent == nil
      y + parent.offset_y
    end
    
    def add sprite
      sprite.parent = self
      
      sprite.width = width - (padding * 2)
      sprite.height = height - (padding * 2)

      sprite.x += padding
      sprite.y += padding

      children << sprite
    end

    def on_render &block
      callbacks << block
    end
    
    def render ctx
      ctx.save
      
      
      if position == :relative
        ctx.translate(x, y)
      else
        ctx.translate(offset_x, offset_y)
      end
      
      if background
        ctx.fill_preserve
        ctx.set_source_color(background)
        ctx.rectangle(0, 0, width, height)
        ctx.fill
      end

      unless callbacks.empty?
        callbacks.each do |cb|
          ctx.save
          instance_exec(ctx, &cb)
          ctx.restore
        end
      end
      
      children.each do |child|
        ctx.save
        child.render ctx
        ctx.restore
      end
      
      ctx.restore
    end

  end

end
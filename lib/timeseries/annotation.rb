

# Just some notes
module TimeSeries

  class Annotation < TimeSeriesSprite

    Labels = "ABCDEFGHIJKLMNOP"

    class << self
      def seed
        @seed = defined?(@seed) ? @seed + 1 : 0 
        @seed
      end
    end

    attr_accessor :thickness, :text, :seed, :label, :time

    def initialize time, text, opts={}, &block
      super(opts)
      
      self.thickness = opts[:thickness] || 1
      self.time = time
      self.text = text
      self.seed = Annotation.seed
      self.label = Labels[seed,1]
      #self.background = opts[:background] || 
      
      size = 20
      margin = 4
      top = y + ((size + margin) * (seed + 1))
      
      on_render do |ctx|

        ctx.translate(calculate_x(time), 0)
      
        Sprite.new(
          :background => 0x000000FF,
          :width => thickness,
          :height => height
        ).render(ctx)
      
        puts label.to_s
        
        TextSprite.new(
          :y => top,
          :x => thickness,
          :width => size,
          :height => size,
          :background => 0x000000FF,
          :color => 0xFFFFFFAA,
          :valign => :top,
          :padding => 6,
          :text => label
        ).render(ctx)
      
      end

    end
    
  end
    
end
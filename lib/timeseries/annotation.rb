

# Just some notes
module TimeSeries

  class Annotation < Sprite

    Labels = "ABCDEFGHIJKLMNOP"

    class << self
      def seed
        @seed = defined?(@seed) ? @seed + 1 : 0 
        @seed
      end
    end

    attr_accessor :thickness, :text, :seed, :label

    def initialize opts={}, &block
      super
      
      self.thickness = opts[:thickness] || 1
      self.text = opts[:text] || ""
      self.seed = Annotation.seed
      self.label = Labels[seed]
      self.background = opts[:background] || 0x000000FF
      
      size = 20
      margin = 4
      top = y + ((size + margin) * (seed + 1))
      
      add Sprite.new(
        :background => background,
        :width => thickness,
        :height => height
      )
      
      add TextSprite.new(
        :y => top,
        :x => thickness,
        :width => size,
        :height => size,
        :background => background,
        :color => 0xFFFFFFAA,
        :valign => :top,
        :padding => 6,
        :text => label
      )

    end
    
  end
    
end
module TimeSeries
  class Timespan < TimeSeriesSprite
      
    attr_accessor :color, :text_color
      
    def initialize from, to, text, opts={}
      super(opts)
      
      self.color = opts[:color] || 0x00000044
      self.text_color = opts[:text_color] || 0x333333FF
      @from = from
      @to = to
      @text = text
      
      on_render do |ctx|
        
        x1 = calculate_x(@from)
        x2 = calculate_x(@to)

        ctx.fill_preserve
        ctx.set_source_color(color)
        ctx.rectangle(x1, 0, x2 - x1, height)
        ctx.fill
        
        TextSprite.new(
          :x => x2 - ((x2 - x1) / 2),
          :y => 10,
          :text => @text,
          :align => :center,
          :valign => :top,
          :color => text_color
        ).render(ctx)
      end
      
    end
  
  
  end
end
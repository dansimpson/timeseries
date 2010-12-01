class Fixnum
  def to_rgb
    [
      (self >> 24 & 0xFF) / 255.0,
      (self >> 16 & 0xFF) / 255.0,
      (self >> 8  & 0xFF) / 255.0,
      (self >> 0  & 0xFF) / 255.0
    ]
  end
end
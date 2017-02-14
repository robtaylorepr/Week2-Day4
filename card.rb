class Card
  attr_accessor :face, :suit, :value

  @ace_value = 11

  def initialize(face = 'A', suit = 'S', value)

    @face = face
    @suit = suit
    @value = value

  end

  def self.ace_value
    @ace_value
  end

  def self.ace_value=(val)
    @ace_value = val
  end

  def self.faces
    %w(2 3 4 5 6 7 8 9 10 J Q K A)
  end

  def self.suits
    %w(C S D H)
  end

  def <(other)
    self.value < other.value
  end

  def >(other)
    self.value > other.value
  end

  def ==(my, other)
    self.value == other.value
  end

  def +(other)
    self.value + other.value
  end

end



class Card
  attr_accessor :face, :suit, :value, :ace
  def initialize(face='A',suit='S')
    @face   = face
    @suit   = suit
    @@ace   = 11
  end

  def self.faces
    %w(2 3 4 5 6 7 8 9 10 J Q K A)
  end

  def self.suits
    %w(C S D H)
  end

  def self.ace
    @@ace
  end

  def self.new_ace(new_value)
    @@ace = new_value
  end

  def value
    result = Card.faces.index(face) + 2
    if result > 10 then result = 10 end
    if face=='A' then result = Card.ace end
    result
  end

  def < (other)
    self.value < other.value
  end

  def > (other)
    self.value > other.value
  end

  def == (my,other)
    self.value == other.value
  end

end

require_relative 'card'
require 'pry'

class Deck < Array
  attr_accessor :deck

  def initialize
    makedeck
  end

  def makedeck

    self.deck = []

    Card.faces.each do |face|
      Card.suits.each do |suit|

        value = [Card.faces.index(face) + 2, 10].min
        value = Card.ace_value if face == 'A'

        card = Card.new(face, suit, value)
        deck << card

      end
      deck
    end

    self.deck.shuffle!

  end

  def empty?
    self.length == 0
  end

  def draw
    deck.shift
  end

end

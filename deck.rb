require_relative 'card'
require 'pry'

class Deck
  attr_accessor :deck
  def initialize
    makedeck
  end

  def makedeck
    suits  = Card.suits
    faces  = Card.faces
    self.deck = []
    faces.each {|face|
      suits.each {|suit|
        card = Card.new
        card.suit  = suit
        card.face  = face
        deck << card
      }
    deck
    }

    def shuffle
      deck.shuffle!
    end

    def empty?
      deck.length == 0
    end

  end

  def draw
    deck.shift
  end

end

#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative 'deck'

class DeckTest < MiniTest::Test

  def setup
    @newdeck = Deck.new
  end

  def test_deck_is_52
    assert_equal 52,@newdeck.deck.length
  end

  def test_contains_13_eachsuit
    Card.suits.each{|suit|
      n = @newdeck.deck.select{|kard|
        kard.suit== suit}.count
      assert_equal 13,n
    }
  end

  def test_contains_four_eachface
    Card.faces.each{|face|
      n = @newdeck.deck.select{|kard|
        kard.face == face}.count
      assert_equal 4,n
    }
  end

  def test_shuffled
    other_deck = Deck.new
    assert @newdeck != other_deck
  end

  def test_draw_reduces_deck
    other = @newdeck.draw
    assert 52 != @newdeck.deck.count
  end

end

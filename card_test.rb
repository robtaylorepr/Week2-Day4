#!/usr/bin/env ruby
require 'minitest/autorun'
require_relative 'card'

class CardTest < MiniTest::Test

  # @card = card
  def setup
    @card = Card.new('J','S')
  end

  def test_card_not_nil
    assert @card.suit  != nil
    assert @card.face  != nil
    assert @card.value != nil
  end

  # An Ace has a value of 14
  def test_Ace_is_11
    @card = Card.new('A','S')
    assert_equal 11,@card.value
  end

  # A King has a value of 10
  def test_King_is_10
    @card = Card.new('K','S')
    assert_equal 10,@card.value
  end

  # An 8 has a value of 8
  def test_Queen_is_8
    @card = Card.new('8','S')
    assert_equal 8,@card.value
  end



end

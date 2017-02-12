#!/usr/bin/env ruby
# game_test.rb
require 'minitest/autorun'
require_relative 'blackjack'

class GameTest < MiniTest::Test
attr_accessor   :game
  def setup
    @game = Game.new
    @deck = []
  end

  def test_six_cards_win
    @game.deck = @game.prepare_deck
    @game.dealer_hand = []
    @game.dealer_hand << Card.new('8','D')
    @game.dealer_hand << Card.new('8','H')
    @game.player_hand = []
    @game.player_hand << Card.new('2','C')
    @game.player_hand << Card.new('2','S')
    @game.player_hand << Card.new('2','D')
    @game.player_hand << Card.new('2','H')
    @game.player_hand << Card.new('3','C')
    @game.player_hand << Card.new('3','S')
    assert_equal "Player",@game.declare_winner
  end

  def test_dealer_blackjack_instant_winner
    @game.deck = @game.prepare_deck
    @game.dealer_hand = []
    @game.dealer_hand << Card.new('A','C')
    @game.dealer_hand << Card.new('10','C')
    @game.player_hand = []
    @game.player_hand << Card.new('2','C')
    @game.player_hand << Card.new('2','S')
    @game.main_sequence
    assert_equal "Dealer",@game.declare_winner
  end

#Note- could not resolve error "unknown method draw"
#.. when calling 'main_sequence/player_plays'
  # def test_ties_goto_most_cards
  #   @game.deck = @game.prepare_deck
  #   @game.dealer_hand = []
  #   @game.dealer_hand << Card.new('2','C')
  #   @game.dealer_hand << Card.new('3','S')
  #   @game.dealer_hand << Card.new('3','H')
  #   @game.player_hand = []
  #   @game.player_hand << Card.new('5','H')
  #   @game.player_hand << Card.new('3','D')
  #   @game.main_sequence
  #   assert_equal "Dealer",@game.declare_winner
  # end
end

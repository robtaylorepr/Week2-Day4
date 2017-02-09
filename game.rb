#!/usr/bin/env ruby
require_relative 'deck'
require 'tty'

class Game
  attr_accessor   :player_hand, :dealer_hand,
                  :winner, :debug, :deck
  def initialize
    self.winner          = nil
    self.player_hand     = []
    self.dealer_hand     = []
    self.deck            = []
    self.debug           = false
  end

  def hand
    hand = []
    hand << deck.draw
    hand << deck.draw
    hand
  end

  def player_plays
    prompt = TTY::Prompt.new
    puts "Player plays"
    show(player_hand)
    until prompt.select("Hit or Stay?", %w(Hit Stay)) == "Stay"
      puts "Hit it"
      player_hand << deck.draw
      show(player_hand)
      if score(player_hand) >= 21 then break end
    end
  end

  def dealer_plays
    puts "Dealer plays"
    show(dealer_hand)
    until score(dealer_hand) > 16
      dealer_hand << deck.draw
      show(dealer_hand)
      if score(dealer_hand) >= 21 then break end
    end
  end

  def declare_winner
    puts "I always win"
  end

  def play
    # create deck a
    self.deck = Deck.new
    self.deck.shuffle

    self.dealer_hand = hand
    self.player_hand = hand

    player_plays
    dealer_plays

    declare_winner
  end

  def show(hand)
    hand.each{|card|
      puts "   #{card.value} of #{card.suit}"
    }
    puts "   score is #{score(hand)}"
  end

  def score(hand)
    hand.reduce(0){|sum,card| sum += card.value}
  end

end

begin
  prompt = TTY::Prompt.new
  game = Game.new
  game.play
  game.winner ? (puts "Winner is #{game.winner}") : (puts "Draw")
  s = "Would you like a rematch (y/n)?"
end until prompt.ask(s)=='n'
puts "Thanks for playing"

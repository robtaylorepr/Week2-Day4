#!/usr/bin/env ruby
require_relative 'deck'
require 'tty'
require 'pry'

class Game
  attr_accessor   :player_hand, :dealer_hand,
                  :winner, :debug, :deck,
                  :wins, :losses, :ties
  def initialize
    self.wins            = 0
    self.losses          = 0
    self.ties            = 0
    self.player_hand     = []
    self.dealer_hand     = []
    self.deck            = []
    self.debug           = false
  end

  def hand
    hand = []
    hand << deck.draw
    hand << deck.draw
    return hand
  end

  def player_plays
    prompt = TTY::Prompt.new
    show("Player",true,player_hand)
    until prompt.select("Hit or Stay?", %w(Hit Stay)) == "Stay"
      player_hand << deck.draw
      show("Player",true,player_hand)
      if score(player_hand) >= 21 then break end
    end
  end

  def dealer_plays
    show("Dealer", false, dealer_hand)
    until score(dealer_hand) >= 16
      dealer_hand << deck.draw
      show("Dealer", false, dealer_hand)
      if score(dealer_hand) >= 21 then break end
    end
  end

  def show_both_scores
    d = score(dealer_hand)
    p = score(player_hand)
    puts ("Player: #{p}, Dealer: #{d}")
  end

  def blackjack(score)
    score == 21
  end

  def bust(score)
    redefine_ace if score > 21
    score > 21
  end

  def redefine_ace
    player_hand.collect do |card|
      if card.face == 'A' then
        n = TTY::Prompt.new.select('Specify a value for Ace:', %w{11 1})
        card.value = n.to_i
        puts "Ace redefined to #{n}."
      end
    end
  end

  def beat(my_score, their_score)
    (my_score > their_score) && !bust(their_score) && !bust(my_score)
  end

  def six(hand)
    (hand.length >= 6) && (score(hand) < 21)
  end

  def player_wins
    ps = score(player_hand) #player score
    ds = score(dealer_hand) #dealer score
    !bust(ps) &&
    (blackjack(ps) || bust(ds) || beat(ps, ds))
  end

  def dealer_wins
    pl = score(player_hand)
    d  = score(dealer_hand)
    !bust(d) &&
    (blackjack(d) || bust(pl) || beat(d, pl))
  end

  def win
    self.wins += 1
  end

  def lose
    self.losses += 1
  end

  def tie
    self.ties += 1
  end

  def declare_winner
    winner = ''
    if six(player_hand)
      puts "Player wins by rule of six"
      win
      winner = "Player"
    elsif player_wins && !dealer_wins
      puts "Player Wins"
      win
      winner = "Player"
    elsif dealer_wins
      puts "Dealer Wins"
      lose
      winner = "Dealer"
    else
      if player_hand.length > dealer_hand.length
        puts "Player Wins by more cards"
        win
        winner = "Player"
      elsif dealer_hand.length > player_hand.length
        puts "Dealer Wins by more cards"
        lose
        winner = "Dealer"
      else
        puts "Player Wins by Tie"
        win
        winner = "Player"
      end
    end
    show_both_scores
    winner
  end

  def prepare_deck
    self.deck = Deck.new
    self.deck.shuffle
  end

  def prepare_hands
    self.dealer_hand = hand
    self.player_hand = hand
  end

  def main_sequence
    if !blackjack(score(dealer_hand))
      show("Dealer", false, dealer_hand)
      player_plays if score(player_hand) < 21
      dealer_plays if score(player_hand) < 21 && score(dealer_hand) < 16
    end
    show("Dealer", true, dealer_hand)
    show("Player", true, player_hand)
    declare_winner
  end

  def show_cumulative
    puts "Cumulative wins:   #{wins}"
    puts "Cumulative losses: #{losses}"
    puts "Cumulative ties:   #{ties}"
  end

  def goodbye
    puts "Thanks for playing"
    show_cumulative
  end

  def rematch
    prompt = TTY::Prompt.new
    s = "Would you like a rematch (y/n)?"
    if prompt.yes?(s) { |q| q.default true }
      play
    else
      goodbye
    end
  end

  def play
    prepare_deck
    prepare_hands
    main_sequence
    rematch
  end

  def show(who, show_first, hand)
    card_number = 1
    puts "#{who}"
    hand.each { |card|
      if show_first || card_number > 1 || debug
        puts "   #{card.face} of #{card.suit}"
      else
        puts "   face-down-card"
      end
      card_number += 1
    }
    puts "   Score:#{score(hand)}" if debug
  end

  def score(hand)
    hand.reduce(0) { |sum, card |
      begin
        sum += card.value
      rescue
        # binding.pry
      end }
  end

end

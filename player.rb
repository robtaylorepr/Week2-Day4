#!/usr/bin/env ruby
# player.rb
require_relative 'blackjack'
require 'tty'


class Player
  attr_accessor   :name, :ace_newvalue
  def initialize(name)
    @name = name
    @@ace = nil
  end
  def play
    Game.new.play
  end
  def play_newace
    Game.new.play(@@ace)
  end
  def self.setace(new_value)
    @@ace = new_value
  end
  def self.getace
    @@ace
  end
  def redefine_ace
    prompt = TTY::Prompt.new
    reply = prompt.select("Redine ACE ?",['y','n'])
    if reply == 'y'
      valid = false
      while !valid
        n = prompt.ask('new value for ACE:')
        if n.to_i.is_a? Integer
          n = n.to_i
          Player.setace(n)
          puts "Ace redefined to be #{n}"
          valid = true
        end
      end
    end
  end
end

player = Player.new("Rob")
player.play

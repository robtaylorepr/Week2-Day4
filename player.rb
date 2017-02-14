#!/usr/bin/env ruby
# player.rb
require 'tty'
require_relative 'blackjack'

class Player
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def play
    Game.new.play
  end

end

player = Player.new("Rob")
player.play

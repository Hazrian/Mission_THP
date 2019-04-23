# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

def perform
  # welcome message
  puts "------------------------------------------------
  |Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
  |Le but du jeu est d'être le dernier survivant !|
  -------------------------------------------------"

  # initialize Game
  puts 'Quel est ton pseudo ?'
  print '>>>'
  pseudo = gets.chomp.to_s
  my_game = Game.new(pseudo)

  # Game loop
  while my_game.is_still_ongoing?
    my_game.show_players
    # my_game.new_players_in_sight
    my_game.menu
    my_game.menu_choice
    my_game.enemies_attack
  end
  my_game.end_game
end

perform

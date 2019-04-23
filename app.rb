# frozen_string_literal: true

require 'bundler'
Bundler.require

# exemple avec un chemin simplifié : require 'nom_fichier'
$:.unshift File.expand_path("./../lib", __FILE__)
require 'game'
# exemple avec chemin du fichier complet : require_relative 'path/nom_fichier'
require_relative 'lib/player'

####################################################
# initialize Game
player1 = Player.new('Josiane')
player2 = Player.new('José')

##### exemple utilité attr_XXXX
# # exemple utilité attr_writer
# puts player1.life_points = 5   # on peut modifier ...
# puts player1.life_points       # ... mais pas lire
#
# # exemple utilité attr_reader
# puts player1.name              # on peut lire ...
# puts player1.name = 'Josi'     # ... mais pas écrire
#
# # exmple utilité attr_accessor
# puts player1.name              # on peut lire ...
# puts player1.name = 'Josi'     # ... mais pas écrire

# Game loop
#while player1.life_points.positive? && player2.life_points.positive?
  # puts "Voici l'état de chauqe joueur :"
  # player1.show_state
  # player2.show_state

  ## exemple methode avec argument
  # player1.get_damage(5)
  # player1.show_state

  # puts "\n>>> Passons à la phase d'attaque :\n "
  # sleep(1)
  # player1.attack(player2)
  # player2.show_state
  # puts '-'*30
  #
  # sleep(1)
  # player2.attack(player1) # if player2.life_points.positive?
  # player1.show_state
  #
  # puts '-'*30
  # puts '-'*30
  #
  # sleep(2)
#end

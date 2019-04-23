# frozen_string_literal: true

require 'bundler'
Bundler.require

require_relative 'lib/game'
require_relative 'lib/player'

# welcome message
puts "------------------------------------------------
|Bienvenue sur 'ILS VEULENT TOUS MA POO' !      |
|Le but du jeu est d'être le dernier survivant !|
-------------------------------------------------"






# initialize HumanPlayer
puts 'Quel est le nom de ton joueur ?'
print '>>>'
player1 = HumanPlayer.new(gets.chomp.to_s)




# initialize des bot
array_bot = [bot1 = Player.new('José'), bot2 = Player.new('Josiane')]







# Game loop
puts 'Début du combat'
while player1.life_points.positive? &&
      (bot1.life_points.positive? || bot2.life_points.positive?)
  player1.show_state


  # menu
  puts ''
  puts 'A toi de jouer'
  puts "Quelle action veux-tu effectuer ?

  a - chercher une meilleure arme
  s - chercher à se soigner

  attaquer un joueur en vie : "

  print '  0 - '
  bot1.show_state
  print '  1 - '
  bot2.show_state

  print '>>>'
  choice = gets.chomp.to_s
  until %w[a s 0 1].include?(choice)
    puts "je n'ai pas compris ton choix"
    print '>>>'
    choice = gets.chomp.to_s
  end
  if choice == 'a'
    player1.search_weapon
    HumanPlayer.weapon
  elsif choice == 's'
    player1.search_health_pack
    HumanPlayer.heal
  elsif choice == '0'
    player1.attack(bot1)
  elsif choice == '1'
    player1.attack(bot2)
  else
    (puts "je n'ai pas compris ton choix")
  end
  sleep(1)
  puts "\n\nLes autres joueurs t'attaquent !\n "
  array_bot.each { |bot|
    if bot.life_points.positive?
      bot.attack(player1)
    else
      puts "le joueur #{bot.name} est mort il ne peut pas attaquer"
    end
  }
  puts '_'*50
  puts '_'*50
  sleep(1)
end

# end of the Game
puts 'La partie est finie'
if player1.life_points.positive?
  puts 'BRAVO ! TU AS GAGNÉ !'
else
  puts 'Loser ! Tu as perdu !'
end

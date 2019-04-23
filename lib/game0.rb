# frozen_string_literal: true

# create Game class
class Game

  # initialize a game with a name and number of enemies (default value = 4)
  def initialize(name, number_enemies = 10)
    @human_player = HumanPlayer.new(name)
    @enemies = Array.new(number_enemies) { |i| Player.new("bot_#{i.to_s}") }
  end

  # delete from enemies list when he is dead
  def kill_player(dead)
    @enemies.delete(dead)
  end

  # check if the game is finish or not
  def is_still_ongoing?
    @human_player.life_points.positive? && (!@enemies.empty?)
  end

  # show statistics of the game life point of player and number of alive enemies
  def show_players
    print '>>>'
    @human_player.show_state
    puts "Il reste #{@enemies.length} ennemis en vue "
  end

  # show what the player can choice
  def menu
    puts "\n>>> Quelle action veux-tu effectuer ?

    a - chercher une meilleure arme
    s - chercher à se soigner

    "
    puts ' attaquer un joueur en vue : '
    @enemies.each do |bot|
      print "#{@enemies.index(bot)} - "
      print "#{bot.show_state}"
    end
  end

    # do the action chose
  def menu_choice
    choice = gets.chomp.to_s

    until valide_choice?(choice)
      puts "je n'ai pas compris ton choix"
      print '>>>'
      choice = gets.chomp.to_s
    end

    if choice == 'a'
      HumanPlayer.weapon
      @human_player.search_weapon
    elsif choice == 's'
      HumanPlayer.heal
      @human_player.search_health_pack
    else
      puts ""
      @human_player.attack(@enemies[choice.to_i])
      if @enemies[choice.to_i].life_points <= 0
        kill_player(@enemies[choice.to_i])
      end
    end
  end

  # check if the choice is valide
  def valide_choice?(choice)
    valide_choice_array = %w[a s]
    @enemies.each do |bot|
      valide_choice_array << @enemies.index(bot).to_s
    end
    valide_choice_array.include?(choice)
  end

  # all enemies attack the player
  def enemies_attack
    print "\n>>>"
    if @enemies.empty?
      print "Il n'y a pas d'ennemis en vue tu n'es donc pas attaqué"
      puts '... pour cette fois'
    end
    @enemies.each do |bot|
      bot.attack(@human_player)
      sleep(0.5)
      puts " "
    end
  end

  # the end of the game win ? or loose ?
  def end_game
    puts 'La partie est finie'
    if @human_player.life_points.positive?
      puts 'BRAVO ! TU AS GAGNÉ !'
      trophy
    else
      puts 'Loser ! Tu as perdu !'
      loose
    end
  end


  # message if you win
  def trophy
    puts "
                                                       .-=========-.
                                                       \\'-=======-'/
__  __                        _                        _|   .=.   |_
\\ \\/ /___  __  __   _      __(_)___                   ((|  {{1}}  |))
 \\  / __ \\/ / / /  | | /| / / / __ \\                   \\|   /|\\   |/
 / / /_/ / /_/ /   | |/ |/ / / / / /                    \\__ '`' __/
/_/\\____/\\__,_/    |__/|__/_/_/ /_/                       _`) (`_
                                                        _/_______\\_
                                                       /___________\\ "
  end

  # message if loose
  def loose
    puts "
                                                                         ,____
                                                                 ___     |---.\\
                                                                / .-\\  ./=)   '
                                                               |  |\"|_/\\/|
                                                               ;  |-;| /_|
__  __               __                                       / \\_| |/ \\ |
\\ \\/ /___  __  __   / /___  ____  ________                   /      \\/\\( |
 \\  / __ \\/ / / /  / / __ \\/ __ \\/ ___/ _ \\                  |   /  |` ) |
 / / /_/ / /_/ /  / / /_/ / /_/ (__  )  __/                  /   \\ _/    |
/_/\\____/\\__,_/  /_/\\____/\\____/____/\\___/                  /--._/  \\    |
                                                            `/|)    |    /
                                                              /     |   |
                                                            .'      |   |
                                                           /         \\  |
                                                          (_.-.__.__./  /
"
  end
end

# frozen_string_literal: true

# new class player
class Player
  attr_accessor :name, :life_points

  # # exemple utilité attr_XXX
  # attr_reader :name
  # attr_writer :life_points

  # initialize a player with a name and life points
  def initialize(name, life_points = 10)
    @name = name
    @life_points = life_points
    # $name = name # exemple variable globale
  end

  # show state of player
  def show_state
    print "Le joueur #{self.name} a #{@life_points}"
    puts " point#{self.life_points > 1 ? 's' : ''} de vie"
  end

  # deal damage to player
  def get_damage(damage)
    self.life_points -= damage
    if self.life_points <= 0
      self.life_points = 0
      puts "Le joueur #{self.name} a été tué !"
    end
  end

  # attack the player in argument
  def attack(player)
    puts "le joueur #{self.name} attaque le joueur #{player.name}"
    damage = compute_damage
    puts "il lui inflige #{damage} points de dommages"
    player.get_damage(damage)
  end

  # private

  # rolled dice to deal damage
  def compute_damage
    rand(1..6)
  end
end

###############################################################################
# new class human player heritate some method to player class
class HumanPlayer < Player
  attr_accessor :weapon_level
  # initialize with on more argument and new life point than player class
  def initialize(name, life_points = 100, weapon_level = 1)
    super(name, life_points)
    @weapon_level = weapon_level
  end

  # redefine show_state for the HumanPlayer class
  def show_state
    print "Le joueur #{self.name} a #{self.life_points}"
    print " point#{self.life_points > 1 ? 's' : ''}"
    puts " de vie et une arme de niveau #{self.weapon_level}"
  end

  # search weapon to upgrade the weapon of HumanPlayer
  def search_weapon
    level_weapon_found = rand(1..6)
    puts "tu as trouvé une arme de niveau #{level_weapon_found}"
    if level_weapon_found > self.weapon_level
      self.weapon_level = level_weapon_found
      puts 'Youhou ! elle est meilleure que ton arme actuelle : tu la prends.'
    else
      puts "... elle n'est pas mieux que ton arme actuelle..."
    end
  end

  # search health pack to heal damaged player
  def search_health_pack
    health_pack_found = rand(1..6)
    if health_pack_found == 1
      puts "Tu n'as rien trouvé ..."
    elsif health_pack_found.between?(2, 5)
      puts 'Bravo, tu as trouvé un pack de +50 points de vie !'
      if self.life_points > 50
        puts 'Tu es maintenant full-life'
        self.life_points = 100
      else
        self.life_points += 50
        puts "Tu as donc #{self.life_points} point de vie maintenant"
      end
    else
      puts 'Waow, tu as trouvé un pack de +80 points de vie !'
      if self.life_points > 20
        puts 'Tu es maintenant full-life'
        self.life_points = 100
      else
        self.life_points += 80
        puts "Tu as donc #{self.life_points} point de vie maintenant"
      end
    end
  end

  # ascii art to search weapon
  def self.weapon
    puts ">>>
,_._._._._._._._._|__________________________________________________________,
|_|_|_|_|_|_|_|_|_|_________________________________________________________/
                  !"
  end

  # ascii art to search health pack
  def self.heal
    puts ">>>
       +++++++
       +:::::+              /~ .~\\    /~  ~\\
       +:::::+             '      `\\/'      *
 +++++++:::::+++++++      (                .*)
 +:::::::::::::::::+       \\            . *./
 +:::::::::::::::::+        `\\ .      . .*/'
 +++++++:::::+++++++          `\\ * .*. */'
       +:::::+                  `\\ * */'
       +:::::+                    `\\/'
       +++++++       "
  end

  private
  # redefine rolled dice with the weapon level
  def compute_damage
    rand(1..6) * self.weapon_level
  end
end

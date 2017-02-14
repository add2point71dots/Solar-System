#sets a noun plural or not
#depending on the number preceding it
def pluralize(num, word)
  if num == 1
    return word
  else
    return word + "s"
  end
end

#puts commas in big numbers
def format_numbers(num)
  num = num.to_s

  if num.index(".") != nil #deal with numbers that have decimals
    start_index = num.index(".") - num.length - 4
    if (num.index(".") % 3) == 0
      num_commas = (num.index(".") / 3) - 1
    else
      num_commas = (num.index(".") / 3)
    end

  else #for numbers without decimals
    start_index = -4
    if (num.length % 3) == 0
      num_commas = (num.length / 3) - 1
    else
      num_commas = (num.length / 3)
    end
  end

  until num_commas <= 0 #insert commas into number
    num.insert(start_index, ",")
    start_index -=4
    num_commas -=1
  end

  return num
end

class SolarSystem
  attr_reader :name, :age, :planets

  #get solar system info from a hash
  def initialize(solar_system_hash)
    @name = solar_system_hash[:name]
    @age = solar_system_hash[:age]
    @planets = {}
  end

  #add one planet to planets hash
  def add_one_planet(planet, planet_info)
    @planets[planet] = planet_info
  end

  #add multiple planets to planet hash
  def add_planets(planet_hash)
    planet_hash.each do |planet, planet_info|
      @planets[planet] = planet_info
    end
  end

  #display hash of planets with numbers
  def print_planets
    planets.each_with_index do |(planet, planet_info), i|
      if i == planets.length-1
        print "#{i+1}. #{planet_info.name}."
      else
        print "#{i+1}. #{planet_info.name}, "
      end
    end
  end

  #get and display distance between one planet
  #and all the others in its solar system
  def compare_distance(planet)
    @planets.each do |oth_planet, oth_planet_info|
      if planet != oth_planet_info
        distance = (planet.distance_from_the_sun - oth_planet_info.distance_from_the_sun).round(2).abs

        puts "#{planet.name} is #{format_numbers(distance)} million miles away from #{oth_planet_info.name}."
      end
    end
  end

  #get and display local year of the planet
  #based on age of solar system and orbit length
  def get_local_year(planet)
    earth_age_in_days = @age * 365.26
    local_year = (earth_age_in_days / planet.orbit).to_i

    puts "Assuming we call the formation of #{@name} year 0, the local year on #{planet.name} is #{format_numbers(local_year)}."
  end
end

class Planet
  attr_reader :name, :type, :diameter, :rings, :moons, :distance_from_the_sun, :rotation_rate, :orbit

  #get planet info from a planet hash
  def initialize(planet_hash)

    #if not enough planet info is supplied
    #some stuff will be weird
    if planet_hash.keys.length < 7
      puts "THINGS ARE NOT WHAT THEY SEEM"
    end

    @name = planet_hash[:name]
    @type = planet_hash[:type]
    @diameter = planet_hash[:diameter]
    @rings = planet_hash[:rings]
    @moons = planet_hash[:moons]
    @distance_from_the_sun = planet_hash[:distance_from_the_sun]
    @rotation_rate = planet_hash[:rotation_rate]
    @orbit = planet_hash[:orbit]
  end

  def print_info #display all info about a planet
    puts "\n#{@name} is a #{@type} planet that is #{format_numbers(@diameter)} miles in diameter. It has #{@rings} #{pluralize(@rings, "ring")} and #{@moons} #{pluralize(@moons, "moon")}. It's #{format_numbers(@distance_from_the_sun)} million miles from the sun and has a rotation rate of #{rotation_rate} Earth #{pluralize(@rotation_rate, "day")}."
  end
end

#store info for a planet in a hash
mercury_hash = {
  name: "Mercury",
  type: "terrestrial",
  diameter: 3032,
  moons: 0,
  rings: 0,
  distance_from_the_sun: 35.98,
  rotation_rate: 59,
  orbit: 87.97
}

#create new instance of planet with its info
mercury = Planet.new(mercury_hash)

venus_hash = {
  name: "Venus",
  type: "terrestrial",
  diameter: 7520.8,
  moons: 0,
  rings: 0,
  distance_from_the_sun: 67.24,
  rotation_rate: 243,
  orbit: 224.7
}

venus = Planet.new(venus_hash)

earth_hash = {
  name: "Earth",
  type: "terrestrial",
  diameter: 7917.5,
  moons: 1,
  rings: 0,
  distance_from_the_sun: 92.96,
  rotation_rate: 1,
  orbit: 365.26
}

earth = Planet.new(earth_hash)

mars_hash = {
  name: "Mars",
  type: "terrestrial",
  diameter: 4212,
  moons: 2,
  rings: 0,
  distance_from_the_sun: 141.6,
  rotation_rate: 1.027,
  orbit: 	686.98
}

mars = Planet.new(mars_hash)

jupiter_hash = {
  name: "Jupiter",
  type: "gas giant",
  diameter: 86881.4,
  moons: 1,
  rings: 4,
  distance_from_the_sun: 483.8,
  rotation_rate: 0.411,
  orbit: 11.86
}

jupiter = Planet.new(jupiter_hash)

saturn_hash = {
  name: "Saturn",
  type: "gas giant",
  diameter: 72367.4,
  moons: 53,
  rings: 7,
  distance_from_the_sun: 888.2,
  rotation_rate: 0.426,
  orbit: 29.46
}

saturn = Planet.new(saturn_hash)

uranus_hash = {
  name: "Uranus",
  type: "gas giant",
  diameter: 31518,
  moons: 27,
  rings: 13,
  distance_from_the_sun: 1784,
  rotation_rate: 0.718,
  orbit: 30685
}

uranus = Planet.new(uranus_hash)

neptune_hash = {
  name: "Neptune",
  type: "gas giant",
  diameter: 30599,
  moons: 13,
  rings: 5,
  distance_from_the_sun: 2795,
  rotation_rate: 0.67,
  orbit: 60190
}

neptune = Planet.new(neptune_hash)

pluto_hash = {
  name: "Pluto",
  type: :dwarf,
  diameter: 1475,
  moons: 5,
  rings: "an unknown number of",
  distance_from_the_sun: 3670,
  rotation_rate: 6.39,
  orbit: 247.92
}

pluto = Planet.new(pluto_hash)

our_solar_system_hash = {
  mercury: mercury,
  venus: venus,
  earth: earth,
  mars: mars,
  jupiter: jupiter,
  saturn: saturn,
  uranus: uranus,
  neptune: neptune,
  pluto: pluto
}

#create instance of solar system
our_solar_system = SolarSystem.new({name: "our solar system", age: 4568000000})

#add hash of planets to the milkey way
our_solar_system.add_planets(our_solar_system_hash)

puts
puts "Let's learn about planets!"

planet_learning = true

while planet_learning #keep asking for planets until user exits
  puts
  puts "#{our_solar_system.name.capitalize} has these planets:"
  our_solar_system.print_planets

  puts #get planet from user
  print "\nWhich planet would you like to learn about? (Or type exit): "
  planet = gets.chomp.downcase

  #force user to type a planet, number of a planet, or exit
  until our_solar_system.planets.include?(planet.to_sym) || ([*1..our_solar_system.planets.length]).include?(planet.to_f) || planet == "exit"

    if planet == "exit" #if 'exit', set up to quit the loop
      planet_learning = false

    else #keep asking for a planet or exit until we get one
      print "Please select a planet listed above. (Or type exit): "
      planet = gets.chomp.downcase
    end
  end

  if planet == "exit" #break out of the while loop
    break
  end

  #if user typed a number, change it to corresponding planet
  if ([*1..our_solar_system.planets.length]).include?(planet.to_f)
    planet = our_solar_system.planets.keys[planet.to_i - 1]
  end

  planet = our_solar_system.planets[planet.to_sym]

  #display info about user's chosen planet
  planet.print_info
  puts

  #display distance between chosen planet
  #and others in its solar system
  our_solar_system.compare_distance(planet)
  puts

  #display info about planet's local year
  our_solar_system.get_local_year(planet)
end

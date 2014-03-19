require 'pg'
require './lib/lines'
require './lib/stations'
require './lib/stops'
require 'readline'
require 'date'

DB = PG.connect({:dbname => 'train_system'})

def welcome

  # d = DateTime.parse('3rd Feb 2001 04:05:06+03:30')
  # puts d.strftime('%I:%M:%S %p')

  puts "Welcome to the train system!"
  main_menu
end

def main_menu
  puts "O - Login as an Operator"
  puts "R - Login as a Rider"
  puts "X - Logout"

  case Readline.readline("> ", true).upcase
  when 'O'
    operator_menu
  when 'R'
    rider_menu
  when 'X'
    puts 'Goodbye!'
  else
    puts 'Invalid input'
    main_menu
  end
end

def operator_menu
  puts 'AS - Add a station'
  puts 'AL - Add a line'
  puts 'S - List all train stations'
  puts 'L - List all train lines'
  puts 'X - Go back'

  case Readline.readline("> ", true).upcase
  when 'AS'
    puts "Enter the station name"
    input = Readline.readline("> ", true).downcase
    new_station = Stations.new({'name' => input})
    new_station.save
    operator_menu
  when 'AL'
    puts "Enter the line name"
    input = Readline.readline("> ", true).downcase
    new_line = Lines.new({'name' => input})
    new_line.save
    operator_menu

  when 'S'
    Stations.all.each_with_index do |station, index|
      puts "#{index+1}: #{station.name}"
    end
    puts "\n\n"
    puts "Enter a station number to view information on that station"
    input = Readline.readline("> ", true).to_i
    view_station(Stations.all[input-1])
  when 'L'
    Lines.all.each_with_index do |line, index|
      puts "#{index+1}: #{line.name}"
    end
    puts "\n\n"
    puts "Enter a line number to view information on that line"
    input = Readline.readline("> ", true).to_i
    view_line(Lines.all[input-1])
  when 'X'
    main_menu
  else
    puts 'Invalid Input'
    operator_menu
  end
end

def view_station(station)
  puts "Name: #{station.name}"

  puts "Lines that run through this station:"
  station.stops.each_with_index do |stop, index|
    puts "#{index+1}: #{stop.name}"
  end

  puts "\n\n"

  puts "R - Remove a line from this station"
  puts "A - Add a line to this station"
  puts "D - Delete this station"
  puts "X - Go back"

  case Readline.readline("> ", true).upcase
  when "R"
    puts "Enter the number of the line you would like to remove"
    new_stop = Stops.new({'station_id' => station.id, 'line_id' => station.stops[Readline.readline("> ", true).to_i-1].id})
    new_stop.delete
    view_station(station)
  when "A"
    Lines.all.each_with_index do |line, index|
      puts "#{index+1}: #{line.name}"
    end
    puts "Enter the number of the line you wish to add to this station"
    input = Readline.readline("> ", true).to_i
    new_stop = Stops.new({'station_id' => station.id, 'line_id' => Lines.all[input-1].id})
    new_stop.save
    puts "Connection made"
    view_station(station)
  when "D"
    station.delete
    puts "'#{station.name}' station has been deleted"
    operator_menu
  when "X"
    operator_menu
  else
    puts "invalid input"
    view_station(station)
  end

end


def view_line(line)
  puts "Name: #{line.name}"
  puts "Stations this line stops at:"
  line.stops.each_with_index do |stop, index|
    puts "#{index+1}: #{stop.name}"
  end
  puts "\n\n"

  puts "R - Remove a station from this line"
  puts "A - Add a station to this line"
  puts "D - Delete this line"
  puts "X - Go back"

  case Readline.readline("> ", true).upcase
  when "R"
   puts "Enter the number of the station you want to remove."
   new_stop = Stops.new({'station_id' => line.stops[Readline.readline("> ", true).to_i-1].id, 'line_id' => line.id})
   new_stop.delete
   view_line(line)
  when "A"
    Stations.all.each_with_index do |station, index|
      puts "#{index+1}: #{station.name}"
    end
    puts "Enter the number of the station you wish to add to this line"
    input = Readline.readline("> ", true).to_i
    new_stop = Stops.new({'station_id' => Stations.all[input-1].id, 'line_id' => line.id})
    new_stop.save
    puts "Connection made"
    view_line(line)
  when "D"
    line.delete
    puts "'#{line.name}' line has been deleted"
    operator_menu
  when "X"
    operator_menu
  else
    puts "invalid input"
    view_line(line)
  end

end

def rider_menu
  puts 'S - List all stations'
  puts 'L - List all lines'
end

welcome

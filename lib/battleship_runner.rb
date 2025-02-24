require 'lib/board'
require 'lib/cell'
require 'lib/ship'
#require 'lib/game'

def main_menu
    puts "Welcome to BATTLESHIP"
    puts "Enter p to play. Enter q to quit."
    choice = gets.chomp.downcase

    while choice != "p" && choice != "q" #to be sure not to quit out early
        puts "Invalid input. Try again."
        puts "Enter p to play. Enter q to quit"
        choice = gets.chomp.downcase
    end

    if choice == "p"
        play_game
    else
        puts "Goodbye!"
    end
end

def play_game
    game = Game.new # Initialize the logic for the game


end

#Remaining Functionality needed to be added

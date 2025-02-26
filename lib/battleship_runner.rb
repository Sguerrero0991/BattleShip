require_relative 'board'
require_relative 'cell'
require_relative 'ship'
require_relative 'game'
require_relative 'turn'

def main_menu
    puts "DEBUG"
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
    game = Game.new # Create a new game instance 

    puts "Computer is placing ships ..."
    game.place_computer_ships
    puts "Computer ships placed"

    puts "I have laid out my ships on the grid."
    puts "You now need to lay out your two ships."
    puts "The Cruiser is three units long and the Submarine is two units long."
    puts game.player_board.render(false)
    game.place_player_ships

    turn = Turn.new(game) #starts the game loop
    turn.play

    puts "Game over, would you like to play again? (y/n)"
    answer = gets.chomp.downcase
    if answer == 'y'
        play_game
    else
        main_menu
    end
end

main_menu



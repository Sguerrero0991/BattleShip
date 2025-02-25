require 'lib/board'
require 'lib/cell'
require 'lib/ship'
require 'lib/game'

class Turn
  def initialize(game)
    @game = game
    @computer_shots = []
  end

  def play
    until game_over?
      display_boards
      player_shot 
      computer_shot unless game_over?
    end
    end_game
  end

  def display_boards
    puts "=============COMPUTER BOARD============="
    puts @game.computer_board.render(false) #Show computer board without ships
    puts "==============PLAYER BOARD=============="
    puts @game.player_board.render(true) #Show player board with ship
  end

  def player_shot
    puts "Enter the coordinate for your shot:"
    coordinate = gets.chomp.upcase
    until @game.computer_board.valid_coordinate?(coordinate) && !@game.computer_board.cells[coordinate].fired_upon?
      puts "Please enter a valid coordinate:"
      coordinate = gets.chomp.upcase
    end
    @game.computer_board.cells[coordinate].fire_upon
    result = shot_result(@game.computer_board, coordinate)
    puts "Your shot on #{coordniate} was a #{result}"
  end

  def computer_shot
    coordinate = (@game.player_board.cells.keys - @computer_shots).sample
    @computer_shots << coordinate
    @game.player_board.cells[coordinate].fire_upon
    result = shot_result(@game.player_board, coordinate)
    puts "Computer shot on #{coordniate} was a #{result}"
  end

  def shot_result(board, coordinate)
    cell = board.cells[coordinate]
    if cell.empty? 
      "miss"
    elsif cell.ship.sunk?
      "hit and sunk a ship"
    else
      "hit"
    end
  end

  def game_over
    @game.player_ships.all? {|ship| ship.sunk?} || @game.computer_ships.all? {|ship| ship.sunk?}
  end

  def end_game
    if (@game.player_ships.all? do |ship|
      ship.sunk?
    end)
    puts "Computer won!"
  else
    puts "Congrats, you won!"
  end
end
class Game
    attr_reader :player_board, 
                :computer_board, 
                :player_cruiser, 
                :player_submarine, 
                :computer_cruiser, 
                :computer_submarine

    def initialize
        @player_board = Board.new
        @computer_board = Board.new
        @player_cruiser = Ship.new("Cruiser", 3)
        @player_submarine = Ship.new("Submarine", 2)
        @computer_cruiser = Ship.new("Cruiser", 3)
        @computer_submarine = Ship.new("Submarine", 2)
    end

    # def setup_computer_ships

    # end

    # def place_computer_ship(ship)

    # end

    # def computer_fire

    # end

    # def game_over?

    # end
end
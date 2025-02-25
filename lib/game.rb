class Game
    # Create reader methods for boards and ship arrays.
    attr_reader :player_board, :computer_board, :player_ships, :computer_ships
  
    # Initializes the game with new boards and two ships for each player.
    def initialize
      @player_board   = Board.new   # Create a new board for the player.
      @computer_board = Board.new   # Create a new board for the computer.
      @player_ships   = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]   # Player's ships.
      @computer_ships = [Ship.new("Cruiser", 3), Ship.new("Submarine", 2)]   # Computer's ships.
    end
  
    # Generates a random candidate placement for the given ship.
    # It computes all horizontal and vertical placements that fit on the board.
      def random_placement(ship)
          all_possible_selections = [
              "A1", "A2", "A3", "A4", 
              "B1", "B2", "B3", "B4", 
              "C1", "C2", "C3", "C4",
              "D1", "D2", "D3", "D4"
                ]
          all_candidates = all_possible_selections.combination(ship.length).to_a
  
          valid_candidates = all_candidates.select do |candidate|
              @computer_board.valid_placement?(ship, candidate)
          end
          valid_candidates.sample
      end
  
    # Places the computer's ships on the board.
    # Uses random_placement and relies on the board's valid_placement? method for validation.
    def place_computer_ships
        @computer_ships.each do |ship|
            placement = random_placement(ship)
            @computer_board.place(ship, placement)
        end 
    end

    # Places the player's ships on the board. 
    # Uses get_vallid_placement helper method to ensure valid placement.
    def place_player_ships
        puts "Player, place your ships on the board"
        @player_ships.each do |ship|
            placement = get_valid_placement(ship)
            @player_board.place(ship, placement)
            puts @player_board.render(true)
        end
    end

    # Helper method
    def get_valid_placement(ship)
        puts "Enter coordinates for your #{ship.name} (#{ship.length} spaces)"
        input = gets.chomp.upcase.split
        if @player_board.valid_placement?(ship, input)
            input
        else
            puts "Invalid placement, please try again"
            get_valid_placement(ship)
        end
    end
end
    
  
  
  
  
  
  
  
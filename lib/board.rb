require './lib/cell'
require 'pry'

class Board 
  attr_reader :cells
  def initialize
    @cells = {} #Creates an empty hash to store the cells

    generate_cells #Call the method to generate cells
  end

  def generate_cells #Define the row labels
    
    rows = ["A", "B", "C", "D"] #Defining the row labels

    columns = ["1", "2", "3", "4"] #Define the column labels

    rows.each do |row|
      columns.each do |column|
        coordinate = row + column #Combining to create coordinate string
        @cells[coordinate] = Cell.new(coordinate) #Assigns new Cell objects with coordinate key
      end
    end
  end

  def valid_coordinate?(coordinate) #Checking the cells hash for the key given
    @cells.key?(coordinate)
  end

  def valid_placement?(ship, coordinates)
    return false unless coordinates.length == ship.length
    return false unless coordinates.all? { |coordinate| valid_coordinate?(coordinate) }
    return false if coordinates.any? { |coordinate| @cells[coordinate].ship}
    
    # Check if coordinates are adjacent (either horizontally or vertically)
    rows = coordinates.map { |coordinate| coordinate[0] }
    columns = coordinates.map { |coordinate| coordinate[1].to_i }
    row_numbers = rows.map { |row| row.ord }
    
    # Check if all rows are the same for horizontal placement
    if rows.uniq.length == 1
      # Check if columns are in strict consecutive order
      return columns.each_cons(2).all? { |a, b| b == a + 1 }
    end
    
    # Check if all columns are the same for vertical placement
    if columns.uniq.length == 1
      # Check if rows are in strict consecutive order
      return row_numbers.each_cons(2).all? { |a, b| b == a + 1 }
    end
    # Coordinates are neither all in the same row nor in the same column
    false
  end

  def place(ship, coordinates)
    return unless valid_placement?(ship, coordinates)

    coordinates.each do |coordinate|
      @cells[coordinate].place_ship(ship)
    end
  end
end


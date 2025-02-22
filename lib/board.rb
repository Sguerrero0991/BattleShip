require './lib/cell'

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
end

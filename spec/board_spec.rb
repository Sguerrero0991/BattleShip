require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Board do
  describe '#initialize' do
    it 'exists' do
     board = Board.new

      expect(board).to be_an(Board)
    end

    it 'has 16 cells in a hash' do
      board = Board.new

      expect(board.cells).to be_a(Hash)
      expect(board.cells.length).to eq(16)
    end
  end

  describe '#generate cells' do
    it 'can generate coordinate pairs with generate_cells' do
      board = Board.new

      expect(board.cells.keys).to eq([
      "A1", "A2", "A3", "A4",
      "B1", "B2", "B3", "B4",
      "C1", "C2", "C3", "C4",
      "D1", "D2", "D3", "D4"
      ])
      board.cells.values.each do |cell|
       expect(cell).to be_a(Cell)
      end
    end
  end

  describe '#validate_coordinate?' do
    it 'returns true for valid coordinates' do
      board = Board.new

      expect(board.valid_coordinate?("A1")).to be true
      expect(board.valid_coordinate?("D4")).to be true
    end

    it 'returns false for invalid coordinates' do
      board = Board.new

      expect(board.valid_coordinate?("A5")).to be false
      expect(board.valid_coordinate?("E1")).to be false
      expect(board.valid_coordinate?("A22")).to be false
    end
  end

  describe '#valid_placement?' do
    it 'returns false if the cell array does not match the length of the ship' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
      expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
    end

    it 'ensures coordinates are consecutive' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
      expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
      expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
      expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
    end

    it 'ensures coordinates are not diagonal' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
      expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
    end

    it 'can have valid placements' do # Happy path testing
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end
  end

  describe '#place' do

    it 'places a ship in the correct cells' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.cells["A1"].ship).to eq(cruiser)
      expect(board.cells["A2"].ship).to eq(cruiser)
      expect(board.cells["A3"].ship).to eq(cruiser)
    end

    it 'ensures the cells the ship are placed on contain the same ship object' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.cells["A3"].ship).to eq(board.cells["A2"].ship) #last part of interaction pattern
    end

    it 'does not allow overlapping ships' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])

      expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end
  end

  describe '#render' do
    it 'renders an empty board' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      #expects
      expect(board.render).to eq(
        "  1 2 3 4 \n" +
        "A . . . . \n" +
        "B . . . . \n" +
        "C . . . . \n" +
        "D . . . . \n"
      )
    end

    it 'shows ships when show_ships is true' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])
      #expects
      expect(board.render(true)).to eq(
        "  1 2 3 4 \n" +
        "A S S S . \n" +
        "B . . . . \n" +
        "C . . . . \n" +
        "D . . . . \n" 
      )
    end

    it 'renders with hits and misses' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C1", "D1"])

      board.cells["A1"].fire_upon
      board.cells["B4"].fire_upon
      board.cells["C1"].fire_upon
      board.cells["D1"].fire_upon

      expect(board.render).to eq(
        "  1 2 3 4 \n" +
        "A H . . . \n" +
        "B . . . M \n" +
        "C X . . . \n" +
        "D X . . . \n"
      )

    end

    it 'renders with ships, hits and misses' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      board.place(cruiser, ["A1", "A2", "A3"])
      board.place(submarine, ["C1", "D1"])

      board.cells["A1"].fire_upon
      board.cells["B4"].fire_upon
      board.cells["C1"].fire_upon
      board.cells["D1"].fire_upon

      expect(board.render(true)).to eq(
        "  1 2 3 4 \n" +
        "A H S S . \n" +
        "B . . . M \n" +
        "C X . . . \n" +
        "D X . . . \n" 
      )
    end
  end
end 

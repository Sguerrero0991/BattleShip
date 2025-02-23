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

    it 'can have valid placements' do
      board = Board.new
      cruiser = Ship.new("Cruiser", 3)
      submarine = Ship.new("Submarine", 2)

      expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
      expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
      #hopefully this works 
    end
  end
end 

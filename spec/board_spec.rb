require './lib/board'
require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Board do
  it 'exists' do
    board = Board.new
    expect(board).to be_an(Board)
  end

  it 'is a board and has 16 cells' do
    board = Board.new
    expect(board.cells).to be(Hash)
    expect(board.cells.length).to eq(16)
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

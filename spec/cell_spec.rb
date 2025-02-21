require './lib/ship'
require './lib/cell'
require 'pry'

RSpec.describe Cell do
  before(:each) do
    @cell = Cell.new("B4")
    @cruiser = Ship.new("Cruiser", 3)
  end 
  describe '#initialize' do
    it 'exists' do
      cell = Cell.new("B4")
      expect(cell).to be_a(Cell)
    end
  end

  describe '#attributes' do
    it 'has coordinates' do
      expect(@cell.coordinate).to eq("B4")
    end

    it 'starts with no ship' do
      expect(@cell.ship).to be(nil)
    end

    it 'checks if cell is empty' do
      expect(@cell.empty?).to eq(true)
    end
  end

  describe '#place_ship' do
    it 'places a ship in a cell' do
      @cell.place_ship(@cruiser)
      expect(@cell.ship).to eq(@cruiser)
      expect(@cell.empty?).to eq(false)
    end
  end
end


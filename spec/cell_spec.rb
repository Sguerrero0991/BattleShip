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
      expect(@cell).to be_a(Cell)
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

  describe '#fired_upon?' do
    it 'checks if a cell has been fired upon' do
      @cell.place_ship(@cruiser)
      expect(@cell.fired_upon?).to eq(false)
    end
  end

  describe '#fire_upon' do
    it 'fires upon a ship' do
      @cell.place_ship(@cruiser)
      @cell.fire_upon
      expect(@cell.ship.health).to eq(2)
      expect(@cell.fired_upon?).to eq(true)
    end
  end

  describe '#render' do
    it 'renders correctly before and after firing' do
      cell_1 = Cell.new("B4")
      expect(cell_1.render).to eq(".")
      cell_1.fire_upon
      expect(cell_1.render).to eq("M")

      cell_2 = Cell.new("C3") 
      cell_2.place_ship(@cruiser)
      expect(cell_2.render).to eq(".")

      expect(cell_2.render(true)).to eq("S")
      cell_2.fire_upon
      expect(cell_2.render).to eq("H")

      expect(@cruiser.sunk?).to eq(false)
      @cruiser.hit
      @cruiser.hit
      expect(@cruiser.sunk?).to eq(true)
      expect(cell_2.render).to eq("X")
    end
  end
end


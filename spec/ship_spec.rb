require './lib/ship'
require 'pry'

RSpec.describe Ship do
    before(:each) do
        @cruiser = Ship.new("Cruiser", 3)
    end
    describe '#inialize' do
        it 'exists' do
            cruiser = Ship.new("Cruiser", 3)
            expect(cruiser).to be_a(Ship)
        end
    end
    describe '#attributes' do
        it 'has a name' do 
            expect(@cruiser.name).to eq("Cruiser")
        end 

        it 'has a length' do
            expect(@cruiser.length).to eq(3)
        end 

        it 'has a base health amount' do
            expect(@cruiser.health).to eq(3)
        end
    end

    describe '#sunk?' do
        it 'defaults to false' do
            expect(@cruiser.sunk?).to eq(false)
        end
    end

    describe '#hit' do
        it 'can be hit and lose health' do
            expect(@cruiser.health).to eq(3)
            @cruiser.hit
            expect(@cruiser.health).to eq(2)
        end

        it 'can be sunk' do
            expect(@cruiser.health).to eq(3)
            @cruiser.hit
            @cruiser.hit
            @cruiser.hit
            expect(@cruiser.health).to eq(0)
            expect(@cruiser.sunk?).to eq(true)
        end
    end
end
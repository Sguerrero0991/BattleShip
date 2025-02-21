require './lib/ship'
require 'pry'

RSpec.describe Ship do
    
    #Add in before each block
    describe '#inialize' do

        it 'exists' do
            cruiser = Ship.new("Cruiser", 3)

            expect(cruiser).to be_a(Ship)
        end

        it 'has attributes' do #split up
            cruiser = Ship.new("Cruiser", 3)

            expect(cruiser.name).to eq("Cruiser")
            expect(cruiser.length).to eq(3)
            expect(cruiser.health).to eq(3)
        end
    end

    describe '#sunk?' do
        it 'defaults to false' do
            cruiser = Ship.new("Cruiser", 3)

            expect(cruiser.sunk?).to eq false
        end
    end

    describe '#hit' do
        it 'can be hit and lose health' do
            cruiser = Ship.new("Cruiser", 3)

            expect(cruiser.health).to eq(3)

            cruiser.hit

            expect(cruiser.health).to eq(2)
        end

        it 'can be sunk' do
            cruiser = Ship.new("Cruiser", 3)

            expect(cruiser.health).to eq(3)

            cruiser.hit
            cruiser.hit
            cruiser.hit

            expect(cruiser.health).to eq(0)
            expect(cruiser.sunk?).to eq true
        end
    end
end
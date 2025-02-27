require './lib/board'
require './lib/ship'
require './lib/cell'
require './lib/game'
require './lib/turn'
require 'pry'

RSpec.describe Turn do

    describe '#initialize' do
        it 'exists' do
            game = Game.new
            turn = Turn.new(game)

            expect(turn).to be_a(Turn)
        end
    end
    describe '#shot_result' do
        it 'correctly reports hit, miss, or sunk ship' do
            game = Game.new
            turn = Turn.new(game)
            ship = Ship.new("Cruiser", 3)

            game.computer_board.place(ship, ["B1", "B2", "B3"])

            expect(turn.shot_result(game.computer_board, "C1")).to eq("miss")
            expect(turn.shot_result(game.computer_board, "B1")).to eq("hit")

            ship.hit
            ship.hit
            ship.hit
        
            expect(turn.shot_result(game.computer_board, "B3")).to eq("hit and sunk a ship")
        end
    end

    describe '#game_over?' do
        it 'correctly determines when the game is over' do
            game = Game.new
            turn = Turn.new(game)

            expect(turn.game_over?).to be false

            game.player_ships.each do |ship| #this might be wrong.
                ship.hit while !ship.sunk?
            end

            expect(turn.game_over?).to be true
        end
    end
end
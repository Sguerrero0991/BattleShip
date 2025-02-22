require './lib/cell'

class Board 
  attr_reader :cell
  def initialize
    @cells = {}
    ("A".."D").each do |letter|
      (1..4).each do |num|
        @cells["#{letter}#{num}"] = Cell.new("#{letter}#{num}")
      end
    end
  end
end

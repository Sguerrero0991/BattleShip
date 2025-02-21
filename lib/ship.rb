class Ship
    attr_reader :name, :length, :health

    def initialize(name, length)
        @name = name
        @length = length
        @health = length
    end

    def sunk?
        @health.zero?
    end

    def hit
        @health -= 1 if @health > 0
    end
end
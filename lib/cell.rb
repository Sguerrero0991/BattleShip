class Cell 
  attr_reader :coordinate, :ship
  def initialize(coordinate)
    @coordinate = coordinate
    @ship = nil
    @fired_upon = false
  end

  def empty?
    @ship.nil?
  end

  def place_ship(ship)
    @ship = ship
  end

  def fired_upon?
    @fired_upon
  end

  def fire_upon
    return if fired_upon? 
    @fired_upon = true

    if @ship
      @ship.hit
    end
  end

  def render(reveal_ship = false)
    if @fired_upon
      if @ship && @ship.sunk?
        return "X"
      elsif @ship
        return "H"
      else
        return "M"
      end
    end
    return "S" if reveal_ship && @ship #revisit
    "." 
  end             
end

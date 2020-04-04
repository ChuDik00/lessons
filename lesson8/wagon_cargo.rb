class WagonCargo < Wagon

  def initialize(number, type =  :cargo, volume)
    @type = type
    super
  end

  def fill_volume(value)
    raise "Нет свободного объема" if value > free_volume
    @take_volume += value
  end
end

class WagonCargo < Wagon

  def initialize(number, type =  :cargo)
    @type = type
    super
  end
end

class TrainCargo < Train

  def initialize(number, type = :cargo)
    super
  end

  def add_wagon(wagon)
    if @type == wagon.type
      super(wagon)
    else
      nil
    end
  end
end

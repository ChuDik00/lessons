class TrainCargo < Train

  def initialize(number, type = 'cargo')
    super
  end

  def add_wagon(wagon)
    if wagon.instance_of?(WagonCargo)
      super(wagon)
    else
      puts 'К грузовому можно цеплять только грузовые вагоны'
    end
  end
end

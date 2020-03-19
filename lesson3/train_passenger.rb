class TrainPassenger < Train

  def initialize(number, type = 'passenger')
    super
  end

  def add_wagon(wagon)
    if wagon.instance_of?(WagonPassenger)
      super(wagon)
    else
      puts 'К пассажирскому можно цеплять только пассажирские вагоны'
    end
  end
end
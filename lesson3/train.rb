class Train
  @@all_trains = []
  attr_reader :number, :type, :route, :wagons
  attr_accessor :current_speed

  def initialize(number, type)
    @number = number
    @type = type
    @current_speed = 0
    @wagons = []
    @@all_trains << self
  end

  def self.all_trains
    @@all_trains
  end

  def increase_speed(speed)
    @current_speed += speed
  end

  def decrease_speed(speed)
    if @current_speed < speed
      @current_speed = 0
    else
      @current_speed -= speed
    end
  end

  def route=(route)
    route.stations.first.incoming_train(self)
    @route = route
  end

  def move_forward
    if @current_speed.positive? && !next_station.nil?
      @current_station.outgoing_train(self)
      next_station.incoming_train(self)
    end
  end

  def move_backward
    if @current_speed.positive? && !prev_station.nil?
      @current_station.outgoing_train(self)
      prev_station.incoming_train(self)
    end
  end

  def to_s
    current_station; prev_station; next_station
    puts "Текущая станция: #{@current_station.title}"
    puts "Предыдущая станция: #{prev_station.title}" if !prev_station.nil?
    puts "Следующая станция: #{next_station.title}" if !next_station.nil?
  end

  protected
  #Должны видеть только дочерние TrainCargo и TrainPassenger
  def current_station
    @route.stations.each do |station|
      if station.trains_list.include?(self)
        @current_station = station
      end
    end
  end

  def next_station
    current_station
    @route.stations[@route.stations.index(@current_station)+1]
  end

  def prev_station
    current_station
    @route.stations[@route.stations.index(@current_station)-1] if (@route.stations.index(@current_station)).positive?
  end

  def add_wagon(wagon)
    @wagons << wagon
  end

  def remove_wagon(wagon)
    @wagons.delete(wagon)
  end
end

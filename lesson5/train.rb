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

  def self.all
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

  def add_wagon(wagon)
    if @wagons.detect{ |w| w == wagon}.nil?
      @wagons << wagon
      puts "Вагон №#{wagon.number} прицеплен к поезду"
    else
      puts 'Этот вагон к поезду уже прицеплен!'
    end
  end

  def remove_wagon(wagon)
    if @wagons.detect{ |w| w == wagon}.nil?
      puts 'Этот вагон к поезду не прицеплен!'
    else
      @wagons.delete(wagon)
      puts "Вагон №#{wagon.number} отцеплен от поезда"
    end
  end

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
end
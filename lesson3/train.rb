class Train
  attr_reader :number, :type, :wagons, :route

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
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

  def add_wagon
    @wagons += 1 if @current_speed.zero?
  end

  def remove_wagon
    @wagons -= 1 if @current_speed.zero? && @wagons.positive?
  end

  def route=(route)
    route.stations.first.incoming_train(self)
    @route = route
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
end

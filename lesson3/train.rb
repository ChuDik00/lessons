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
    @wagons += 1 if @current_speed == 0
  end

  def remove_wagon
    @wagons -= 1 if @current_speed == 0 && @wagons.positive?
  end

  def move_forward
    @current_station += 1 if @current_speed.positive? && @current_station < @route.stations.size-1
  end

  def move_backward
    @current_station -= 1 if @current_speed.positive? && @current_station.positive?
  end

  def route=(route)
    @current_station = 0
    @route = route
  end

  def display
    puts "Текущая станция: #{@route.stations[@current_station]}"
    puts "Предыдущая станция: #{@route.stations[@current_station-1]}" if @current_station.positive?
    puts "Следующая станция: #{@route.stations[@current_station+1]}" if @current_station < @route.stations.size-1
  end
end

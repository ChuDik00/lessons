class Train
  attr_reader :wagons, :current_speed, :type

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
    if speed > @current_speed
      @current_speed = 0
    else
      @current_speed -= speed
    end
  end

  def add_wagon
    @wagons += 1 if @current_speed == 0
  end

  def remove_wagon
    @wagons -= 1 if @current_speed == 0 && @wagon.positive?
  end

  def add_route(route)
    @current_route = route
    @currunt_station = route.stations[0]
  end

  def move_forward
    @currunt_station += 1 if @current_speed.positive?
  end

  def move_backward
    @currunt_station -= 1 if @current_speed.positive?
  end

  def display_stations
    puts "Текущая станция: #{@current_route.stations[@currunt_station]}"
    puts "Предыдущая станция: #{@current_route.stations[@currunt_station-1]}"
    puts "Следующая станция: #{@current_route.stations[@currunt_station+1]}"
  end
end

require_relative './manufacturer'
require_relative './instance_counter'
require_relative './validate'
class Train
  include Manufacturer
  include InstanceCounter
  include Validate
  @@all_trains = []
  attr_reader :number, :type, :route, :wagons
  attr_accessor :current_speed

  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @current_speed = 0
    @wagons = []
    @@all_trains << self
    register_instance
  end

  def self.all
    @@all_trains
  end

  def self.find(number)
    Train.all.detect { |train| train.number == number }
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
      @wagons << wagon
  end

  def remove_wagon(wagon)
      @wagons.delete(wagon)
  end

  def current_station
    @route.stations.each do |station|
      if station.trains_list.include?(self)
        @current_station = station
      end
    end
    @current_station
  end

  def next_station
    current_station
    @route.stations[@route.stations.index(@current_station)+1]
  end

  def prev_station
    current_station
    @route.stations[@route.stations.index(@current_station)-1] if (@route.stations.index(@current_station)).positive?
  end

  def validate!
    raise "Номер поезда не должен быть пустым!" if number.empty?
    raise "Тип поезда не должен быть пустым!" if type.empty?
    raise "Номер поезда не соответствует формату шаблона" if number !~ NUMBER_FORMAT
  end
end

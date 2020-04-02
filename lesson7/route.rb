require_relative './instance_counter'
require_relative './validate'
class Route
  include InstanceCounter
  include Validate
  @@all_routes = []
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
    validate!
    @stations = [start, finish]
    @@all_routes << self
    register_instance
  end

  def self.all
    @@all_routes
  end

  def add_station(station)
    @stations.insert(@stations.index(@stations.last), station)
  end

  def delete_station(station)
    if @stations.include?(station)
      @stations.delete(station)
    else
      print 'Такой станции в маршруте нет!'
    end
  end

  def to_s
    stations = @stations.map { |station| station.title }.join(", ")
    puts "Станции на маршруте:  #{stations}"
  end
  protected

  def validate!
    raise "Обе станции не должны быть пустыми!" if start.empty? || finish.empty?
  end
end

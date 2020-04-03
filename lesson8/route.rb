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
    @stations = [start, finish]
    validate!
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
    @stations.delete(station) if @stations.include?(station)
  end

  def to_s
    stations = @stations.map { |station| station.title }.join(", ")
    puts "Список станций маршрута:  #{stations}"
  end
  protected

  def validate!
    validate_route!
  end
end

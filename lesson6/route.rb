require_relative './instance_counter'
class Route
  include InstanceCounter
  @@all_routes = []
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
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
end

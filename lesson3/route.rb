class Route
  attr_reader :stations

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(@stations.index(@stations.last), station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def to_s
    @stations.map { |station| station.title }
  end
end

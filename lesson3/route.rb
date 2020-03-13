class Route

  def initialize(start, finish)
    @start = start
    @finish = finish
    @stations = [start, finish]
  end

  def add_station(station)
    @stations.insert(@stations.index(@stations.last), station)
  end

  def del_station(station)
    @stations.delete(station)
  end

  def stations
    puts @stations.join(', ')
    @stations
  end

end

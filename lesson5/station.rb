class Station
  @@all_stations = []
  attr_reader :trains_list, :title

  def initialize(title)
    @title = title
    @trains_list = []
    @@all_stations << self
  end

  def self.all
    @@all_stations
  end

  def incoming_train(train)
    @trains_list << train
  end

  def outgoing_train(train)
    @trains_list.delete(train)
  end

  def trains_type
    trains_type = {}
    @trains_list.each { |train| trains_type[train.type] = [] }
    trains_type.each do |type, array|
      trains_type[type] = @trains_list.select { |train| train.type == type }
    end
  end

  def to_s
    @trains_list.each { |train| puts "Поезд №#{train.number}, тип: #{train.type}, к-во вагонов: #{train.wagons}"}
    trains_type.each { |type, array| puts "Поездов типа: #{type}: #{array.size} ед."}
  end
end

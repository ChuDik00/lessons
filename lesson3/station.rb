class Station
  attr_reader :trains_list, :title

  def initialize(title)
    @title = title
    @trains_list = []
  end

  def incoming_train(train)
    @trains_list << train
  end

  def outgoing_train(train)
    @trains_list.delete(train)
  end

  def trains_type
    @trains_type = {}
    @trains_list.each do |train|
      @trains_type[train.type] = []
    end
    @trains_type.each do |type, array|
      @trains_type[type] = @trains_list.select { |i| i.type == type}
    end
  end

  def to_s
    @trains_list.each { |train| puts "Поезд №#{train.number}, тип: #{train.type}, к-во вагонов: #{train.wagons}"}
  end
end

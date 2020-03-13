class Station

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
    types = Hash.new(0)
    @trains_list.each { |train| types[train.type] += 1 }
    types = types.sort
    types.each { |type, count| puts "Поездов типа #{type}: #{count} ед."}
  end

  def trains_list
    @trains_list.each { |train| puts "Поезд №#{train.number}, тип: #{train.type}, к-во вагонов: #{train.wagons}"}
  end
end

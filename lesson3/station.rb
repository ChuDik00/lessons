class Station
  attr_writer :station
  attr_reader :list_of_trains

  def initialize(title)
    @title = title
    @list_of_trains = []
  end

  def incoming_train(train)
    @list_of_trains << train
  end

  def outgoing_train(train)
    @list_of_trains.delete(train)
  end

  def list_of_trains_type
    types = Hash.new(0)
    @list_of_trains.each { |train| types[train.type] += 1 }
    types = types.sort
    types.each { |type, count| puts "Поездов типа #{type}: #{count} ед."}
  end

end

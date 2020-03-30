class Wagon
  @@all_wagons = []
  attr_accessor :number, :train
  attr_reader :info,  :type

  def initialize(number, type)
    @number = number
    @type = type
    @train = train
    @@all_wagons << self
  end

  def self.all
    @@all_wagons
  end

  def info
    puts "Тип #{@type}"
  end
end

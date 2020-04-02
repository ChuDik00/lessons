require_relative './manufacturer'
require_relative './validate'
class Wagon
  include Manufacturer
  include Validate
  @@all_wagons = []
  attr_accessor :number, :train
  attr_reader :info,  :type

  def initialize(number, type)
    @number = number
    @type = type
    @train = train
    validate_number!
    validate_type!
    @@all_wagons << self
  end

  def self.all
    @@all_wagons
  end

  def self.find(number)
    Wagon.all.detect { |wagon| wagon.number == number }
  end

  def info
    puts "Тип #{@type}"
  end
  protected

  def validate_number!
    raise "Номер вагона не может быть пустым!" if number.empty?
  end

  def validate_type!
    raise "Тип вагона не может быть пустым!" if type.empty?
  end
end

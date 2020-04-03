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
    validate!
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

  def validate!
    validate_number!
    validate_type!
  end
end

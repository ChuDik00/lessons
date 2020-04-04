require_relative './manufacturer'
require_relative './validate'
class Wagon
  include Manufacturer
  include Validate
  @@all_wagons = []
  attr_accessor :number, :train
  attr_reader :info,  :type, :volume, :take_volume

  def initialize(number, type, volume)
    @number = number
    @type = type
    @volume = volume
    @take_volume = 0
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

  def free_volume
    @volume - @take_volume
  end

  def info
    if @type == :passenger
      puts "Вагон № #{@number}, тип: #{@type}, свободных мест: #{free_volume}, занятых мест: #{@take_volume}"
    elsif @type == :cargo
      puts "Вагон № #{@number}, тип: #{@type}, свободный объем: #{free_volume}, занятый объем: #{@take_volume}"
    end
  end

  protected

  attr_writer :take_volume

  def validate!
    validate_number!
    validate_type!
  end

end

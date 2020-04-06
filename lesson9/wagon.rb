# frozen_string_literal: true

require_relative './manufacturer'
require_relative './validate'
class Wagon
  include Manufacturer
  include Validate
  @@all_wagons = []
  attr_accessor :number, :train
  attr_reader :type, :volume, :take_volume

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
    wagon = "Вагон № #{@number}"
    type =  "Тип: #{@type}"
    if @type == :passenger
      free_value = "Свободных мест: #{free_volume}"
      take_value = "Занятых мест: #{@take_volume}"
    elsif @type == :cargo
      free_value = "Свободный объем: #{free_volume}"
      take_value = "Занятый объем: #{@take_volume}"
    end
    puts "#{wagon}, #{type}, #{free_value}, #{take_value}"
  end

  protected

  attr_writer :take_volume

  def validate!
    validate_number!
    validate_type!
  end
end

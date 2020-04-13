# frozen_string_literal: true

require_relative './manufacturer'
require_relative './validation'
class Wagon
  include Manufacturer
  include Validation
  @@all_wagons = []
  attr_accessor :number, :train
  attr_reader :type, :volume, :take_volume

  def initialize(number, options = {})
    @number = number
    @volume = options[:volume]
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
end

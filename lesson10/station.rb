# frozen_string_literal: true

require_relative './instance_counter'
require_relative './validation'
class Station
  include InstanceCounter
  include Validation
  @@all_stations = []

  validate :title, :presence
  attr_reader :trains_list, :title

  def initialize(title)
    @title = title
    @trains_list = []
    validate!
    @@all_stations << self
    register_instance
  end

  def self.all
    @@all_stations
  end

  def self.find(title)
    Station.all.detect { |station| station.title == title }
  end

  def incoming_train(train)
    @trains_list << train
  end

  def outgoing_train(train)
    @trains_list.delete(train)
  end

  def to_s
    each_train(&:info_train)
    trains_type.each do |type, array|
      puts "Поездов типа: #{type}: #{array.size} ед."
    end
  end

  def each_train
    @trains_list.each { |train| yield(train) }
  end

  protected

  def trains_type
    trains_type = {}
    @trains_list.each { |train| trains_type[train.type] = [] }
    trains_type.each do |type, _array|
      trains_type[type] = @trains_list.select { |train| train.type == type }
    end
  end
end

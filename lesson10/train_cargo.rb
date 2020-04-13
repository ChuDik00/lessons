# frozen_string_literal: true

class TrainCargo < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, type = :cargo)
    super
  end
end

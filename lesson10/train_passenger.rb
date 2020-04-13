# frozen_string_literal: true

class TrainPassenger < Train
  validate :number, :presence
  validate :number, :format, NUMBER_FORMAT


  def initialize(number, type = :passenger)
    super
  end
end

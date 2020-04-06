# frozen_string_literal: true

class WagonPassenger < Wagon
  def initialize(number, type = :passenger, volume)
    @type = type
    super
  end

  def fill_volume
    raise 'Нет свободных мест' if free_volume.zero?

    @take_volume += 1
  end
end

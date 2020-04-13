# frozen_string_literal: true

class WagonPassenger < Wagon
  validate :number, :presence
  validate :volume, :zero

  def initialize(number, options = {})
    @type = options[:type] || :passenger
    super
  end

  def fill_volume
    raise 'Нет свободных мест' if free_volume.zero?

    @take_volume += 1
  end
end

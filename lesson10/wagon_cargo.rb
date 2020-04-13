# frozen_string_literal: true

class WagonCargo < Wagon
  validate :number, :presence
  validate :volume, :zero

  def initialize(number, options = {})
    @type = options[:type] || :cargo
    super
  end

  def fill_volume(value)
    raise 'Нет свободного объема' if value > free_volume

    @take_volume += value
  end
end

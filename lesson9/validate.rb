# frozen_string_literal: true

module Validate
  NUMBER_FORMAT = /^[a-z0-9]{3}-?[a-z0-9]{2}$/i.freeze

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def validate_number!
    raise 'Номер не должен быть пустым!' if number.empty?
  end

  def validate_type!
    raise 'Тип не должен быть пустым!' if @type.empty?
  end

  def validate_title!
    raise 'Название не должно быть пустым!' if title.empty?
  end

  def validate_route!
    raise 'Обе станции не должны быть пустыми!' if @start.nil? || @finish.nil?
  end

  def validate_format!
    raise 'Номер не соответствует формату шаблона' if number !~ NUMBER_FORMAT
  end

  def validate_volume!
    raise 'Объем не может быть пустым' if @volume.zero?
  end
end

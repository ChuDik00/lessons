module Validate
  def valid?
    validate!
    true
  rescue
    false
  end

  def validate_number!
    raise "Номер не должен быть пустым!" if number.empty?
  end

  def validate_type!
    raise "Тип не должен быть пустым!" if type.empty?
  end

  def validate_title!
    raise "Название не должно быть пустым!" if title.empty?
  end

  def validate_route!
    raise "Обе станции не должны быть пустыми!" if start.empty? || finish.empty?
  end

end

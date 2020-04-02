module Validate
  def valid?
    validate!
    true
    puts "validate true"
  rescue
    false
    puts "validate false"
  end

  protected
  def validate!
    raise "Название не может быть пустым!" if @title == ""
  end

end

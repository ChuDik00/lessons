require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

class Interface

  def menu
    puts 'Введите 1 для добавления станции, поезда, вагона или маршрута.'
    puts 'Введите 2 для проведения операций с созданными объектами.'
    puts 'Введите 3 для выведения текущих данных об объектах.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1

    when 2

    when 3

    when 0
      exit
    end

  end

  def choice
    @choice = gets.chomp
  end
end

interface = Interface.new
interface.menu
require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

class Interface

  def choice
    @choice = gets.chomp
  end

  def main_menu
    puts 'Введите 1 для добавления станции, поезда, вагона или маршрута.'
    puts 'Введите 2 для проведения операций с созданными объектами.'
    puts 'Введите 3 для выведения текущих данных об объектах.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      adding_objects_menu
    when 2
      # вывести меню для операций
    when 3
      # вывести меню для отчетов
    when 0
      exit
    else
      puts 'Сделайте правильный выбор'
      main_menu
    end

  end

  def adding_objects_menu
    puts 'Введите 1 для добавления станции.'
    puts 'Введите 2 для добавления поезда.'
    puts 'Введите 3 для добавления вагона.'
    puts 'Введите 4 для добавления маршрута.'
    puts 'Введите 0 для возвращения в главное меню.'
    case choice.to_i
    when 1
      # добавление станции
    when 2
      # добавление поезда
    when 3
      # добавление вагона
    when 4
      # добавление маршрута
    when 0
      exit
    else
      puts 'Сделайте правильный выбор'
      adding_objects_menu
    end


  end

end

interface = Interface.new
interface.main_menu
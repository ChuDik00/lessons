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
      objects_menu
    when 2
      operating_menu
    when 3
      output_menu
    when 0
    else
      puts 'Неправильный выбор!'
      main_menu
    end
  end

  def objects_menu
    puts 'Введите 1 для добавления станции.'
    puts 'Введите 2 для добавления поезда.'
    puts 'Введите 3 для добавления вагона.'
    puts 'Введите 4 для добавления маршрута.'
    puts 'Введите 5 для возвращения в главное меню.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      # добавление станции
    when 2
      # добавление поезда
    when 3
      # добавление вагона
    when 4
      # добавление маршрута
    when 5
      main_menu
    when 0
    else
      puts 'Неправильный выбор!'
      adding_objects_menu
    end
  end

  def operating_menu
    puts 'Введите 1 для прицепления вагона к поезду.'
    puts 'Введите 2 для отцепления вагона от поезда.'
    puts 'Введите 3 увеличения скорости поезда.'
    puts 'Введите 4 для уменьшения скорости поезда.'
    puts 'Введите 5 для перемещения на следующую станцию.'
    puts 'Введите 6 для перемещения на предыдущую станцию.'
    puts 'Введите 7 для добавления станции к маршруту.'
    puts 'Введите 8 для удаления станции из маршрута.'
    puts 'Введите 9 для возвращения в главное меню.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      # прицепление вагона к поезду
    when 2
      # отцепление вагона от поезда
    when 3
      # увеличение скорости поезда
    when 4
      # уменьшение скорости поезда
    when 5
      # перемещение на следующую станцию
    when 6
      # перемещение на предыдущую станцию
    when 7
      # добавление станции к маршруту
    when 8
      # удаление станции из маршрута
    when 9
      main_menu
    when 0
    else
      puts 'Неправильный выбор!'
      operating_menu
    end
  end

  def output_menu
    puts 'Введите 1 для вывода списка станций.'
    puts 'Введите 2 для вывода списка поездов на станции.'
    puts 'Введите 3 для возвращения в главное меню.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      # вывод списка станций
    when 2
      # вывод списка поездов на станции
    when 3
      main_menu
    when 0
    else
      puts 'Неправильный выбор!'
      output_menu
    end
  end
end

interface = Interface.new
interface.main_menu
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

  def find_train(number)
    Train.all.detect { |train| train.number == number }
  end

  def find_station(title)
    Station.all.detect { |station| station.title == title }
  end

  def find_wagon(number)
    Wagon.all.detect { |wagon| wagon.number == number }
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
      exit
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
      add_station
    when 2
      add_train_menu
    when 3
      add_wagon_menu
    when 4
      add_route
    when 5
      main_menu
    when 0
      exit
    else
      puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    objects_menu
  end

  def add_station
    print 'Введите название станции: '
    choice
    Station.new(@choice)
    puts "Добавлена станция с названием: #{@choice}"
  end

  def add_train_menu
    puts 'Введите 1 для добавления пассажирского поезда.'
    puts 'Введите 2 для добавления грузового поезда.'
    puts 'Введите 3 для возврата в предыдущее меню.'
    puts 'Введите 4 для возврата в главное.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      add_passenger_train
    when 2
      add_cargo_train
    when 3
      objects_menu
    when 4
      main_menu
    when 0
      exit
    end
    puts 'Выберите, что делать дальше:'
    add_train_menu
  end

  def add_passenger_train
    print 'Введите номер поезда: '
    choice
    if !find_train(@choice).nil?
      puts 'Такой номер поезда уже есть!'
    else
      TrainPassenger.new(@choice)
      puts "Добавлен пассажирский поезд с номером: #{@choice}"
    end
  end

  def add_cargo_train
    print 'Введите номер поезда: '
    choice
    if !find_train(@choice).nil?
      puts 'Такой номер поезда уже есть!'
    else
      TrainCargo.new(@choice)
      puts "Добавлен грузовой поезд с номером: #{@choice}"
    end
  end

  def add_wagon_menu
    puts 'Введите 1 для добавления пассажирского вагона.'
    puts 'Введите 2 для добавления грузового вагона.'
    puts 'Введите 3 для возврата в предыдущее меню.'
    puts 'Введите 4 для возврата в главное.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      add_passenger_wagon
    when 2
      add_cargo_wagon
    when 3
      objects_menu
    when 4
      main_menu
    when 0
      exit
    end
    puts 'Выберите, что делать дальше:'
    add_wagon_menu
  end

  def add_passenger_wagon
    print 'Введите номер вагона: '
    choice
    if !find_wagon(@choice).nil?
      puts 'Такой номер вагона уже есть!'
    else
      WagonPassenger.new(@choice)
      puts "Добавлен пассажирский вагон с номером: #{@choice}"
    end
  end

  def add_cargo_wagon
    print 'Введите номер вагона: '
    choice
    if !find_wagon(@choice).nil?
      puts 'Такой номер вагона уже есть!'
    else
      WagonCargo.new(@choice)
      puts "Добавлен грузовой вагон с номером: #{@choice}"
    end
  end

  def add_route
    if Station.all.size < 2
      puts 'Для создания маршрута нужны минимум 2 станции.'
      add_station
    else
      loop do
        print 'Введите название первой станции маршрута: '
        choice
        if find_station(@choice).nil?
          puts 'Такой станции нет в списке станций!'
          break
        else
          first = find_station(@choice)
        end
        print 'Введите название последней станции маршрута: '
        choice
        if find_station(@choice).nil?
          puts 'Такой станции нет в списке станций!'
          break
        else
          last = find_station(@choice)
        end
        route = Route.new(first, last)
        puts "Добавлен маршрут #{route.stations.first.title}-#{route.stations.last.title}"
        break
      end
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
      exit
    else
      puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    operating_menu
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
      exit
    else
      puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    output_menu
  end
end

interface = Interface.new
interface.main_menu
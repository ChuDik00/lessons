require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

class Interface
  def init
    main_menu
  end

  private
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
    print 'Введите название новой станции: '
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
    else
      puts 'puts Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    add_train_menu
  end

  def add_passenger_train
    print 'Введите номер поезда: '
    choice
    if !Train.find(@choice).nil?
      puts 'Такой номер поезда уже есть!'
    else
      TrainPassenger.new(@choice)
      puts "Добавлен пассажирский поезд с номером: #{@choice}"
    end
  end

  def add_cargo_train
    print 'Введите номер поезда: '
    choice
    if !Train.find(@choice).nil?
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
    else
      puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    add_wagon_menu
  end

  def add_passenger_wagon
    print 'Введите номер вагона: '
    choice
    if !Wagon.find(@choice).nil?
      puts 'Такой номер вагона уже есть!'
    else
      WagonPassenger.new(@choice)
      puts "Добавлен пассажирский вагон с номером: #{@choice}"
    end
  end

  def add_cargo_wagon
    print 'Введите номер вагона: '
    choice
    if !Wagon.find(@choice).nil?
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
        print'Введите № поезда: '
        choice
        train = Train.find(@choice)
        if train.nil?
          puts 'Такого поезда нет!'
        else
          print 'Введите название первой станции маршрута: '
          choice
          if Station.find(@choice).nil?
            puts 'Такой станции нет в списке станций!'
            break
          else
            first = Station.find(@choice)
          end
          print 'Введите название последней станции маршрута: '
          choice
          if Station.find(@choice).nil?
            puts 'Такой станции нет в списке станций!'
            break
          else
            last = Station.find(@choice)
          end
          route = Route.new(first, last)
          train.route=route
          puts "Добавлен маршрут #{route.stations.first.title}-#{route.stations.last.title}"
          puts "Маршрут #{route.stations.first.title}-#{route.stations.last.title} назначен поезду №#{train.number}"
          break
        end
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
      add_wagon_to_train_menu
    when 2
      remove_wagon_from_train
    when 3
      increase_speed
    when 4
      decrease_speed
    when 5
      move_forward
    when 6
      move_backward
    when 7
      insert_station_in_route
    when 8
      delete_station_from_route
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

  def add_wagon_to_train_menu
    puts 'Введите 1 для прицепления пассажирского вагона.'
    puts 'Введите 2 для прицепления грузового вагона.'
    puts 'Введите 3 для возврата в предыдущее меню.'
    puts 'Введите 4 для возврата в главное.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      add_passenger_wagon_to_train
    when 2
      add_cargo_wagon_to_train
    when 3
      operating_menu
    when 4
      main_menu
    when 0
      exit
    else
      puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    add_wagon_to_train_menu
  end

  def add_passenger_wagon_to_train
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      if train.type == :cargo
        puts 'Пассажирский вагон можно цеплять только к пассажирскому поезду!'
      else
        print 'Введите номер вагона: '
        choice
        wagon = Wagon.find(@choice)
        if wagon.nil?
          puts 'Такого номера вагона нет!'
        elsif wagon.type == :cargo
          puts 'Это не пассажирский вагон'
        elsif !wagon.train.nil? && wagon.train.number == train.number
          puts "Вагон №#{wagon.number} уже прицеплен к поезду №#{train.number}"
        elsif !wagon.train.nil?
          puts "Вагон №#{wagon.number} прицеплен к поезду №#{wagon.train.number}, сначала отцепите его."
          remove_wagon_from_train
        else
          train.add_wagon(wagon)
          wagon.train = train if train.wagons.include?(wagon)
          puts "Вагон №#{wagon.number} прицеплен к поезду №#{train.number}"
        end
      end
    end
  end

  def add_cargo_wagon_to_train
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      if train.type == :passenger
        puts 'Грузовой вагон можно цеплять только к грузовому поезду!'
      else
        print 'Введите номер вагона: '
        choice
        wagon = Wagon.find(@choice)
        if wagon.nil?
          puts 'Такого номера вагона нет!'
        elsif wagon.type == :passenger
          puts 'Это не грузовой вагон'
        elsif !wagon.train.nil? && wagon.train.number == train.number
          puts "Вагон №#{wagon.number} уже прицеплен к поезду №#{train.number}"
        elsif !wagon.train.nil?
          puts "Вагон №#{wagon.number} прицеплен к поезду №#{wagon.train.number}, сначала отцепите его."
          remove_wagon_from_train
        else
          train.add_wagon(wagon)
          wagon.train = train if train.wagons.include?(wagon)
          puts "Вагон №#{wagon.number} прицеплен к поезду №#{train.number}"
        end
      end
    end
  end

  def remove_wagon_from_train
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      print 'Введите номер вагона: '
      choice
      wagon = Wagon.find(@choice)
      if wagon.nil?
        puts 'Такого номера вагона не существует!'
      elsif wagon.train != train
        puts "Вагон номер №#{wagon.number} не прицеплен к поезду №#{train.number}."
      else
        train.remove_wagon(wagon)
        wagon.train = nil unless train.wagons.include?(wagon)
        puts "Вагон номер №#{wagon.number} отцеплен от поезда №#{train.number}."
      end
    end

  end

  def increase_speed
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      print 'Введите, на сколько нужно увеличить скорость: '
      choice
      train.increase_speed(@choice.to_i)
      puts "Скорость поезда №#{train.number} увеличена на #{@choice} км/ч"
    end
  end

  def decrease_speed
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      print 'Введите, на сколько нужно уменьшить скорость: '
      choice
      train. decrease_speed(@choice.to_i)
      puts "Скорость поезда №#{train.number} уменьшена на #{@choice} км/ч"
    end
  end

  def move_forward
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      train.move_forward
      current_station = train.current_station
      puts "Поезд №#{train.number} переместился на станцию #{current_station.title}"
    end
  end

  def move_backward
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      train.move_backward
      current_station = train.current_station
      puts "Поезд №#{train.number} переместился на станцию #{current_station.title}"
    end
  end

  def insert_station_in_route
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    elsif train.route.nil?
      puts "Поезду №#{train.number} маршрут не назначен."
    else
      print 'Введите название станции для добавления к маршруту: '
      choice
      station = Station.find(@choice)
      if station.nil?
        puts 'Такой станции нет!'
        add_station
        insert_station_in_route
      else
        train.route.add_station(station)
        puts "Станция #{station.title}  добавлена к маршруту поезда №#{train.number}"
      end
    end
  end

  def  delete_station_from_route
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    elsif train.route.nil?
      puts "Поезду №#{train.number} маршрут не назначен."
    else
      print 'Введите название станции для удаления из маршрута: '
      choice
      station = Station.find(@choice)
      if station.nil?
        puts 'Такой станции нет!'
      elsif !train.route.stations.include?(station)
        puts "Станция #{station.title} не присутствует в маршруте поезда №#{train.number}"
      else
        train.route.delete_station(station)
        puts "Станция #{station.title} удалена из маршрута поезда №#{train.number}"
      end
    end
  end

  def output_menu
    puts 'Введите 1 для вывода списка станций.'
    puts 'Введите 2 для вывода списка поездов на станции.'
    puts 'Введите 3 для возвращения в главное меню.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1
      report_list_of_stations
    when 2
      report_list_of_trains_on_station
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

  def report_list_of_stations
    puts "Список станций: #{Station.all.map{ |station| station.title }.join(", ")}"
  end

  def report_list_of_trains_on_station
    report_list_of_stations
    print 'Введите название станции: '
    choice
    station = Station.find(@choice)
    if station.nil?
      puts 'Такой станции нет в природе!'
    elsif station.trains_list.nil?
      puts "На станции #{station.title} нет поездов."
    else
      station.to_s
    end
  end
end


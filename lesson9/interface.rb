# frozen_string_literal: true

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

  def list_main_menu
    puts <<~EOS
    Введите 1 для добавления станции, поезда, вагона или маршрута.
    Введите 2 для проведения операций с созданными объектами.
    Введите 3 для выведения текущих данных об объектах.
    Введите 0 для завершения работы.
    EOS
  end

  def main_menu
    list_main_menu
    case choice.to_i
    when 1 then objects_menu
    when 2 then operating_menu
    when 3 then output_menu
    when 0 then exit
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
    when 1 then add_station
    when 2 then add_train_menu
    when 3 then add_wagon_menu
    when 4 then add_route
    when 5 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    objects_menu
  end

  def add_station
    print 'Введите название новой станции: '
    choice
    Station.new(@choice)
  rescue RuntimeError => e
    puts e.message
  end

  def add_train_menu
    puts 'Введите 1 для добавления пассажирского поезда.'
    puts 'Введите 2 для добавления грузового поезда.'
    puts 'Введите 3 для возврата в предыдущее меню.'
    puts 'Введите 4 для возврата в главное.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1 then add_passenger_train
    when 2 then add_cargo_train
    when 3 then objects_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    add_train_menu
  end

  def add_passenger_train
    print 'Введите номер поезда: '
    choice
    raise 'Такой номер поезда уже есть!' unless Train.find(@choice).nil?

    TrainPassenger.new(@choice)
    puts "Добавлен пассажирский поезд с номером: #{@choice}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def add_cargo_train
    print 'Введите номер поезда: '
    choice
    raise 'Такой номер поезда уже есть!' unless Train.find(@choice).nil?

    TrainCargo.new(@choice)
    puts "Добавлен грузовой поезд с номером: #{@choice}"
  rescue RuntimeError => e
    puts e.message
    retry
  end

  def add_wagon_menu
    puts 'Введите 1 для добавления пассажирского вагона.'
    puts 'Введите 2 для добавления грузового вагона.'
    puts 'Введите 3 для возврата в предыдущее меню.'
    puts 'Введите 4 для возврата в главное.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1 then add_passenger_wagon
    when 2 then add_cargo_wagon
    when 3 then objects_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    add_wagon_menu
  end

  def add_passenger_wagon
    print 'Введите номер вагона: '
    choice
    raise 'Такой номер вагона уже есть!' unless Wagon.find(@choice).nil?

    print 'Введите общее количество мест в вагоне: '
    seats = gets.chomp.to_i
    WagonPassenger.new(@choice, volume: seats)
    puts "Добавлен пассажирский вагон с номером: #{@choice}"
  rescue RuntimeError => e
    puts e.message
  end

  def add_cargo_wagon
    print 'Введите номер вагона: '
    choice
    raise 'Такой номер вагона уже есть!' unless Wagon.find(@choice).nil?

    print 'Введите общий объем вагона: '
    volume = gets.chomp.to_i
    WagonCargo.new(@choice, volume: volume)
    puts "Добавлен грузовой вагон с номером: #{@choice}"
  rescue RuntimeError => e
    puts e.message
  end

  def add_route
    if Station.all.size < 2
      puts 'Для создания маршрута нужны минимум 2 станции.'
      add_station
    else
      loop do
        print 'Введите № поезда: '
        choice
        train = Train.find(@choice)
        if train.nil?
          puts 'Такого поезда нет!'
          objects_menu
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
          train.route = route
          stations = route.stations
          puts "Добавлен маршрут #{stations.first.title}-#{stations.last.title}"
          puts "Новый маршрут назначен поезду №#{train.number}"
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
    puts 'Введите 9 для занимания места или объема в вагоне.'
    puts 'Введите 10 для возвращения в главное меню.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1 then add_wagon_to_train_menu
    when 2 then remove_wagon_from_train
    when 3 then increase_speed
    when 4 then decrease_speed
    when 5 then move_forward
    when 6 then move_backward
    when 7 then insert_station_in_route
    when 8 then delete_station_from_route
    when 9 then take_volume_in_wagon_menu
    when 10 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    operating_menu
  end

  def take_volume_in_wagon_menu
    puts 'Введите 1 для занимания места в пассажирском вагоне.'
    puts 'Введите 2 для занимания объема в грузовом вагоне.'
    puts 'Введите 3 для возврата в предыдущее меню.'
    puts 'Введите 4 для возврата в главное.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1 then take_volume_in_passenger_wagon
    when 2 then take_volume_in_cargo_wagon
    when 3 then operating_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    take_volume_in_wagon_menu
  end

  def take_volume_in_passenger_wagon
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    raise puts 'Такого номера поезда нет!' if train.nil?

    print 'Введите номер вагона: '
    choice
    wagon = Wagon.find(@choice)
    raise 'Такого номера вагона нет!' if wagon.nil?
    raise 'Вагон не прицеплен к поезду' unless train.wagons.include?(wagon)

    wagon.fill_volume
    wagon.info
  rescue StandardError => e
    puts e.message
  end

  def take_volume_in_cargo_wagon
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    raise StandardError, 'Такого номера поезда нет!' if train.nil?

    print 'Введите номер вагона: '
    choice
    wagon = Wagon.find(@choice)
    raise 'Такого номера вагона нет!' if wagon.nil?

    raise 'Вагон не прицеплен к поезду' unless train.wagons.include?(wagon)

    print 'Введите количество занимаемого объема вагона: '
    volume = gets.chomp.to_i
    raise 'Объем должен быть больше 0' if volume <= 0

    wagon.fill_volume(volume)
    wagon.info
  rescue StandardError => e
    puts e.message
  end

  def add_wagon_to_train_menu
    puts 'Введите 1 для прицепления пассажирского вагона.'
    puts 'Введите 2 для прицепления грузового вагона.'
    puts 'Введите 3 для возврата в предыдущее меню.'
    puts 'Введите 4 для возврата в главное.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1 then add_passenger_wagon_to_train
    when 2 then add_cargo_wagon_to_train
    when 3 then operating_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
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
    elsif train.type == :cargo
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
        puts "Вагон №#{wagon.number} сцеплен с поездом №#{wagon.train.number}"
        puts 'Сначала отцепите его.'
        remove_wagon_from_train
      else
        train.add_wagon(wagon)
        wagon.train = train if train.wagons.include?(wagon)
        puts "Вагон №#{wagon.number} прицеплен к поезду №#{train.number}"
      end
    end
  end

  def add_cargo_wagon_to_train
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    elsif train.type == :passenger
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
        puts "Вагон №#{wagon.number} сцеплен с поездом №#{wagon.train.number}"
        puts 'Сначала его надо отцепить.'
        remove_wagon_from_train
      else
        train.add_wagon(wagon)
        wagon.train = train if train.wagons.include?(wagon)
        puts "Вагон №#{wagon.number} прицеплен к поезду №#{train.number}"
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
        puts "Вагон №#{wagon.number} не прицеплен к поезду №#{train.number}."
      else
        train.remove_wagon(wagon)
        wagon.train = nil unless train.wagons.include?(wagon)
        puts "Вагон №#{wagon.number} отцеплен от поезда №#{train.number}."
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
      number = train.number
      train.move_forward
      current_station = train.current_station
      title = current_station.title
      puts "Поезд №#{number} переместился на станцию #{title}"
    end
  end

  def move_backward
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    else
      number = train.number
      train.move_backward
      current_station = train.current_station
      title = current_station.title
      puts "Поезд №#{number} переместился на станцию #{title}"
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
      number = train.number
      print 'Введите название станции для добавления к маршруту: '
      choice
      station = Station.find(@choice)
      if station.nil?
        puts 'Такой станции нет!'
        add_station
        insert_station_in_route
      else
        title = station.title
        train.route.add_station(station)
        puts "Станция #{title}  добавлена к маршруту поезда №#{number}"
      end
    end
  end

  def delete_station_from_route
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    if train.nil?
      puts 'Такого номера поезда нет!'
    elsif train.route.nil?
      puts "Поезду №#{train.number} маршрут не назначен."
    else
      number = train.number
      print 'Введите название станции для удаления из маршрута: '
      choice
      station = Station.find(@choice)
      if station.nil?
        puts 'Такой станции нет!'
      elsif !train.route.stations.include?(station)
        title = station.title
        puts "Станция #{title} не присутствует в маршруте поезда №#{number}"
      else
        title = station.title
        train.route.delete_station(station)
        puts "Станция #{title} удалена из маршрута поезда №#{number}"
      end
    end
  end

  def output_menu
    puts 'Введите 1 для вывода списка станций.'
    puts 'Введите 2 для вывода списка поездов на станции.'
    puts 'Введите 3 для вывода списка вагонов у поезда.'
    puts 'Введите 4 для возвращения в главное меню.'
    puts 'Введите 0 для завершения работы.'
    case choice.to_i
    when 1 then report_list_of_stations
    when 2 then report_list_of_trains_on_station
    when 3 then report_list_wagons
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    puts 'Выберите, что делать дальше:'
    output_menu.join(', ')
  end

  def report_list_of_stations
    stations = Station.all.map(&:title).join(', ')
    puts "Список станций: #{stations}"
  end

  def report_list_of_trains_on_station
    report_list_of_stations
    print 'Введите название станции: '
    choice
    station = Station.find(@choice)
    raise 'Такой станции нет в природе!' if station.nil?
    raise "На станции #{station.title} нет поездов." if station.trains_list.nil?

    station.to_s
  rescue RuntimeError => e
    puts e.message
  end

  def report_list_wagons
    print 'Введите номер поезда: '
    choice
    train = Train.find(@choice)
    raise 'Такого поезда не существует!' if train.nil?
    raise "У поезда №#{train.number} нет вагонов." if train.wagons.empty?

    train.info_wagons
  rescue RuntimeError => e
    puts e.message
  end
end

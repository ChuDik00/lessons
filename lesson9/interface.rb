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

  LIST_MAIN_MENU = <<~LIST
    Введите 1 для добавления станции, поезда, вагона или маршрута.
    Введите 2 для проведения операций с созданными объектами.
    Введите 3 для выведения текущих данных об объектах.
    Введите 0 для завершения работы.
  LIST

  LIST_OBJECT_MENU = <<~LIST
    Введите 1 для добавления станции.
    Введите 2 для добавления поезда.
    Введите 3 для добавления вагона.
    Введите 4 для добавления маршрута.
    Введите 5 для возвращения в главное меню.
    Введите 0 для завершения работы.
  LIST

  LIST_TRAIN_MENU = <<~LIST
    Введите 1 для добавления пассажирского поезда.
    Введите 2 для добавления грузового поезда.
    Введите 3 для возврата в предыдущее меню.
    Введите 4 для возврата в главное.
    Введите 0 для завершения работы.
  LIST

  LIST_WAGON_MENU = <<~LIST
    Введите 1 для добавления пассажирского вагона.
    Введите 2 для добавления грузового вагона.
    Введите 3 для возврата в предыдущее меню.
    Введите 4 для возврата в главное.
    Введите 0 для завершения работы.
  LIST

  LIST_OPERATING_MENU = <<~LIST
    Введите 1 для прицепления вагона к поезду.
    Введите 2 для отцепления вагона от поезда.
    Введите 3 увеличения скорости поезда.
    Введите 4 для уменьшения скорости поезда.
    Введите 5 для перемещения на следующую станцию.
    Введите 6 для перемещения на предыдущую станцию.
    Введите 7 для добавления станции к маршруту.
    Введите 8 для удаления станции из маршрута.
    Введите 9 для занимания места или объема в вагоне.
    Введите 10 для возвращения в главное меню.
    Введите 0 для завершения работы.
  LIST

  LIST_TAKE_WAGON_MENU = <<~LIST
    Введите 1 для занимания места в пассажирском вагоне.
    Введите 2 для занимания объема в грузовом вагоне.
    Введите 3 для возврата в предыдущее меню.
    Введите 4 для возврата в главное.
    Введите 0 для завершения работы.
  LIST

  LIST_ADD_WAGON_TO_TRAIN = <<~LIST
    Введите 1 для прицепления пассажирского вагона.
    Введите 2 для прицепления грузового вагона.
    Введите 3 для возврата в предыдущее меню.
    Введите 4 для возврата в главное.
    Введите 0 для завершения работы.
  LIST

  LIST_OUTPUT_MENU = <<~LIST
    Введите 1 для вывода списка станций.
    Введите 2 для вывода списка поездов на станции.
    Введите 3 для вывода списка вагонов у поезда.
    Введите 4 для возвращения в главное меню.
    Введите 0 для завершения работы.
  LIST

  def main_menu
    puts LIST_MAIN_MENU
    case choice.to_i
    when 1 then objects_menu
    when 2 then operating_menu
    when 3 then output_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    main_menu
  end

  # rubocop:disable Metrics/MethodLength
  def objects_menu
    puts LIST_OBJECT_MENU
    case choice.to_i
    when 1 then add_station
    when 2 then add_train_menu
    when 3 then add_wagon_menu
    when 4 then add_route
    when 5 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    objects_menu
  end

  def operating_menu
    puts LIST_OPERATING_MENU
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
    operating_menu
  end
  # rubocop:enable Metrics/MethodLength

  def add_station
    print 'Введите название новой станции: '
    choice
    Station.new(@choice)
  rescue RuntimeError => e
    puts e.message
  end

  def add_train_menu
    puts LIST_TRAIN_MENU
    case choice.to_i
    when 1 then add_passenger_train
    when 2 then add_cargo_train
    when 3 then objects_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
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
    puts LIST_WAGON_MENU
    case choice.to_i
    when 1 then add_passenger_wagon
    when 2 then add_cargo_wagon
    when 3 then objects_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
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

  def choice_train
    print 'Введите № поезда: '
    choice
    raise 'Такого поезда нет!' if Train.find(@choice).nil?

    Train.find(@choice)
  end

  def choice_station
    choice
    raise 'Такой станции нет в списке станций!' if Station.find(@choice).nil?

    Station.find(@choice)
  end

  def add_route
    train = choice_train
    print 'Введите название первой станции: '
    first = choice_station
    print 'Введите название второй станции: '
    last = choice_station
    route = Route.new(first, last)
    train.route = route
  rescue RuntimeError => e
    puts e.message
    objects_menu
  end

  def take_volume_in_wagon_menu
    puts LIST_TAKE_WAGON_MENU
    case choice.to_i
    when 1 then take_volume_in_passenger_wagon
    when 2 then take_volume_in_cargo_wagon
    when 3 then operating_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    take_volume_in_wagon_menu
  end

  def choice_wagon
    print 'Введите номер вагона: '
    choice
    raise 'Такого номера вагона нет!' if Wagon.find(@choice).nil?

    Wagon.find(@choice)
  end

  def take_volume_in_passenger_wagon
    train = choice_train
    wagon = choice_wagon
    raise 'Вагон не прицеплен к поезду' unless train.wagons.include?(wagon)

    wagon.fill_volume
    wagon.info
  rescue StandardError => e
    puts e.message
  end

  def take_volume_in_cargo_wagon
    train = choice_train
    wagon = choice_wagon
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
    puts LIST_ADD_WAGON_TO_TRAIN
    case choice.to_i
    when 1 then add_passenger_wagon_to_train
    when 2 then add_cargo_wagon_to_train
    when 3 then operating_menu
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    add_wagon_to_train_menu
  end

  def validate_passenger_train!
    raise 'Это не пассажирский поезд!' if @train.type == :cargo
  end

  def validate_cargo_train!
    raise 'Это не грузовой поезд!' if @train.type == :passenger
  end

  def validate_wagon!
    raise 'Вагон уже прицеплен к этому поезду' if
        !@wagon.train.nil? && @wagon.train.number == @train.number
    raise 'Вагон прицеплен к другому поезду' unless @wagon.train.nil?
  end

  def add_passenger_wagon_to_train
    @train = choice_train
    validate_passenger_train!
    @wagon = choice_wagon
    raise 'Это не пассажирский вагон' if @wagon.type == :cargo

    validate_wagon!
    @train.add_wagon(@wagon)
    @wagon.train = @train if @train.wagons.include?(@wagon)
    puts "Вагон №#{@wagon.number} прицеплен к поезду №#{@train.number}"
  rescue RuntimeError => e
    puts e.message
  end

  def add_cargo_wagon_to_train
    @train = choice_train
    validate_cargo_train!
    @wagon = choice_wagon
    raise 'Это не грузовой вагон' if @wagon.type == :passenger

    validate_wagon!
    @train.add_wagon(@wagon)
    @wagon.train = @train if @train.wagons.include?(@wagon)
    puts "Вагон №#{@wagon.number} прицеплен к поезду №#{@train.number}"
  rescue RuntimeError => e
    puts e.message
  end

  def remove_wagon_from_train
    train = choice_train
    wagon = choice_wagon
    raise 'Вагон не прицеплен к этому поезду' if wagon.train != train

    train.remove_wagon(wagon)
    wagon.train = nil unless train.wagons.include?(wagon)
    puts "Вагон №#{wagon.number} отцеплен от поезда №#{train.number}."
  rescue RuntimeError => e
    puts e.message
  end

  def increase_speed
    train = choice_train
    print 'Введите  , на сколько нужно увеличить скорость: '
    choice
    train.increase_speed(@choice.to_i)
    puts "Скорость поезда №#{train.number} увеличена на #{@choice} км/ч"
  rescue RuntimeError => e
    puts e.message
  end

  def decrease_speed
    train = choice_train
    print 'Введите, на сколько нужно уменьшить скорость: '
    choice
    train. decrease_speed(@choice.to_i)
    puts "Скорость поезда №#{train.number} уменьшена на #{@choice} км/ч"
  rescue RuntimeError => e
    puts e.message
  end

  def move_forward
    train = choice_train
    number = train.numberfirst
    train.move_forward
    current_station = train.current_station
    title = current_station.title
    puts "Поезд №#{number} переместился на станцию #{title}"
  rescue RuntimeError => e
    puts e.message
  end

  def move_backward
    train = choice_train
    number = train.number
    train.move_backward
    current_station = train.current_station
    title = current_station.title
    puts "Поезд №#{number} переместился на станцию #{title}"
  rescue RuntimeError => e
    puts e.message
  end

  def validate_insert_station!
    raise 'Эта станция уже в маршруте' if
        @train.route.stations.include?(@station)
  end

  def validate_deleted_station!
    raise 'Нельзя удалять крайние станции маршрута' if
        @station == @train.route.start || @station == @train.route.finish
  end

  def insert_station_in_route
    @train = choice_train
    raise 'Этому поезду маршрут не назначен' if @train.route.nil?

    print 'Введите название добавляемой станции: '
    @station = choice_station
    validate_insert_station!
    title = @station.title
    @train.route.add_station(@station)
    puts "Станция #{title}  добавлена к маршруту поезда №#{@train.number}"
  rescue RuntimeError => e
    puts e.message
  end

  def delete_station_from_route
    @train = choice_train
    raise 'Этому поезду маршрут не назначен' if @train.route.nil?

    print 'Введите название удаляемой станции: '
    @station = choice_station
    unless @train.route.stations.include?(@station)
      raise 'Станция не присутствует в маршруте поезда'
    end

    validate_deleted_station!
    @train.route.delete_station(@station)
    puts "Станция #{@station.title} удалена из маршрута"
  end

  def output_menu
    puts LIST_OUTPUT_MENU
    case choice.to_i
    when 1 then report_list_of_stations
    when 2 then report_list_of_trains_on_station
    when 3 then report_list_wagons
    when 4 then main_menu
    when 0 then exit
    else puts 'Неправильный выбор!'
    end
    output_menu
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

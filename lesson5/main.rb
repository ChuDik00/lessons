require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

def find_train(number)
  Train.all.detect { |train| train.number == number }
end

def find_station(title)
  Station.all.detect { |station| station.title == title }
end

def find_wagon(number)
  Wagon.all.detect { |wagon| wagon.number == number }
end


loop do
  puts %Q(
1.  Добавление станции, поезда, вагона или маршрута
2.  Операции с созданными объектами
3.  Выведение текущих данных об объектах
0.  Выход )
  print 'Выберите  из списка номер задачи: '
  choice = gets.chomp.to_i
  case choice
  when 0 #Выход
    puts 'Работа закончена.'
    break
  when 1 #Добавление станции, поезда, вагона или маршрута
    loop do
      puts %Q(
  1.  Добавление станции
  2.  Добавление поезда
  3.  Добавление маршрута
  4.  Добавление вагона
  0.  Выход в верхнее меню )
      print 'Выберите  из списка номер задачи: '
      choice = gets.chomp.to_i
      case choice
      when 0 #Выход в верхнее меню
        puts 'Выход в верхнее меню'
        break
      when 1 #Добавление станции
        print 'Введите название станции: '
        station_name = gets.chomp.to_s
        Station.new(station_name)
        puts   "Добавлена станция #{station_name}"
      when 2 #Добавление поезда
        print 'Введите номер поезда: '
        train_number = gets.chomp.to_s
        if !find_train(train_number).nil?
          puts 'Такой номер поезда уже есть.'
        else
          print 'Какой поезд? 1-пассажирский или 2-грузовой: '
          train_type = gets.chomp.to_i
          case train_type
          when 1
            TrainPassenger.new(train_number)
          when 2
            TrainCargo.new(train_number)
          else
            puts 'Надо вводить 1 или 2 для выбора типа поезда'
          end
        end
      when 3 #Добавление маршрута/удаление
        loop do
          print'Введите № поезда: '
          train_number = gets.chomp
          if find_train(train_number).nil?
            puts 'Такого поезда нет!'
            break
          else
            train = find_train(train_number)
          end
          print 'Добавьте первую станцию маршрута: '
          station_first = gets.chomp
          if find_station(station_first).nil?
            puts 'Такой станции нет!'
            nil
            break
          else
            first = find_station(station_first)
          end
          print 'Добавьте последнюю станцию маршрута: '
          station_last = gets.chomp
          if find_station(station_last).nil?
            puts 'Такой станции нет!'
            nil
            break
          else
            last = find_station(station_last)
          end
          route = Route.new(first, last)
          train.route=route
          puts "Маршрут #{route.stations.first.title}-#{route.stations.last.title} назначен поезду №#{train.number}"
          break
        end
      when 4 #Добавление вагона
         loop do
           print 'Введите № вагона: '
           wagon_number = gets.chomp.to_s
           if !find_wagon(wagon_number).nil?
             puts 'Такой вагон уже есть!'
             break
           else
             print 'Выберите тип вагона: 1-пассажирский, 2-грузовой: '
             wagon_type = gets.chomp.to_i
             case wagon_type
             when 1
               WagonPassenger.new(wagon_number)
               puts "Добавлен пассажирский вагон №#{wagon_number}"
               break
             when 2
               WagonCargo.new(wagon_number)
               puts "Добавлен грузовой вагон №#{wagon_number}"
               break
             end
           end
        end
      end
    end
  when 2 #Операции с созданными объектами
    loop do
      puts %Q(
  1.  Добавление/отцепление вагона от поезда
  2.  Увеличить/уменьшить скорость поезда
  3.  Переместить поезд по маршруту
  4.  Добавить/удалить станцию из маршрута
  0.  Выход в верхнее меню )
      print 'Выберите  из списка номер задачи: '
      choice = gets.chomp.to_i
      case choice
      when 0 #Выход на верхний уровень
        puts 'Выход в верхнее меню'
        break
      when 1 #Добавление/отцепление вагона
        loop do
          print'Введите № поезда: '
          train_number = gets.chomp
          if find_train(train_number).nil?
            puts 'Такого поезда нет!'
            break
          else
            train = find_train(train_number)
            print '1-добавить вагон, 2-отцепить вагон: '
            choice = gets.chomp.to_i
            case choice
            when 1
              print 'Введите № вагона: '
              wagon_number = gets.chomp.to_s
              if find_wagon(wagon_number).nil?
                puts 'Такого вагона нет природе!'
                break
              else
                wagon = find_wagon(wagon_number)
                train.add_wagon(wagon)
                wagon.train = train if train.wagons.include?(wagon)
                break
              end
            when 2
              print 'Введите № вагона: '
              wagon_number = gets.chomp
              if find_wagon(wagon_number).nil?
                puts 'Такого вагона нет в природе!'
                break
              else
                wagon = find_wagon(wagon_number)
                train.remove_wagon(wagon)
                wagon.train = nil if !train.wagons.include?(wagon)
                break
              end
            end
          end
        end
      when 2 #Увеличить/уменьшить скорость поезда
        loop do
          print 'Введите № поезда: '
          train_number = gets.chomp
          if find_train(train_number).nil?
            puts 'Такого поезда нет!'
            break
          else
            train = find_train(train_number)
            print 'Выберите: 1-для увеличения скорости поезда, 2-для уменьшения скорости поезда: '
            choice = gets.chomp.to_i
            case choice
            when 1
              print 'Введите, на сколько нужно увеличить скорость: '
              speed = gets.chomp.to_i
              train.increase_speed(speed)
              puts "Скорость увеличена на #{speed} км/ч"
              break
            when 2
              print 'Введите, на сколько нужно уменьшить скорость: '
              speed = gets.chomp.to_i
              train.decrease_speed(speed)
              puts "Скорость уменьшена на #{speed} км/ч"
              break
            end
          end
        end
      when 3 #Переместить поезд по маршруту
        loop do
          print 'Введите № поезда: '
          train_number = gets.chomp
          if find_train(train_number).nil?
            puts 'Такого поезда нет!'
            break
          else
            train = find_train(train_number)
            print 'Выберите: 1-для движения вперед, 2-для движения назад: '
            choice = gets.chomp.to_i
            case choice
            when 1
              train.move_forward
              break
            when 2
              train.move_backward
              break
            end
          end
        end
      when 4 #Добавить/удалить станцию из маршрута
        loop do
          print 'Введите № поезда: '
          train_number = gets.chomp
          if find_train(train_number).nil?
            puts 'Такого поезда нет, соответственно нет маршрута!'
            break
          else
            train = find_train(train_number)
            print 'Выберите: 1-для добавления станции, 2-для удаления станции: '
            choice = gets.chomp.to_i
            print 'Введите название станции: '
            station_title = gets.chomp
            if find_station(station_title).nil?
              puts 'Такой станции нет в природе!'
              break
            else
              station = find_station(station_title)
              case choice
              when 1
                train.route.add_station(station)
                break
              when 2
                train.route.delete_station(station)
                break
              end
            end
          end
        end
      end
    end
  when 3 #Выведение текущих данных об объектах
    loop do
      puts %Q(
  1.  Вывести список станций
  2.  Вывести список поездов на станции
  0.  Выход в верхнее меню )
      print 'Выберите  из списка номер задачи: '
      choice = gets.chomp.to_i
      case choice
      when 0 #Выход на верхний уровень
        puts 'Выход в верхнее меню'
        break
      when 1
        puts "Список станций: #{Station.all.map{ |station| station.title }.join(", ")}"
      when 2
        loop do
          print 'Введите название станции: '
          station_title = gets.chomp
          if find_station(station_title).nil?
            puts 'Такой станции нет в природе!'
            break
          else
            station = find_station(station_title)
            station.to_s
          end
          break
        end
      end
    end
  end
end


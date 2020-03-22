require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

def seed
  tc = TrainCargo.new(12345)
  wc = WagonCargo.new(1111)
  wp = WagonPassenger.new(5555)
  p Wagon.all
end
# seed

def find_train(number)
  Train.all.detect { |train| train.number == number }
end

def output_train
  print'Введите № поезда: '
  train_number = gets.chomp
  if find_train(train_number).nil?
    puts 'Такого поезда нет!'
  else
    find_train(train_number)
  end
end

def find_station(title)
  Station.all.detect { |station| station.title == title }
end

def output_station
  station_title = gets.chomp
  if find_station(station_title).nil?
    puts 'Такой станции нет!'
    nil
    break
  else
    find_station(station_title)
  end
end

def find_wagon(number)
  Wagon.all.detect { |wagon| wagon.number == number }
end

def output_wagon
  print'Введите номер вагона: '
  wagon_number = gets.chomp
  if find_wagon(wagon_number).nil?
    puts 'Такого вагона нет!'
    nil
    break
  else
    find_wagon(wagon_number)
  end
end


def start
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
                train = output_train
                print 'Добавьте первую станцию маршрута: '
                first = output_station
                print 'Добавьте последнюю станцию маршрута: '
                last = output_station
                route = Route.new(first, last)
                train.route=route
                puts "Маршрут #{route.stations.first.title}-#{route.stations.last.title} назначен поезду №#{train.number}"
                break
              end
            break
        when 4 #Добавление вагона
           loop do
             print 'Введите № вагона: '
             wagon_number = gets.chomp.to_s
             print 'Выберите тип вагона: 1-пассажирский, 2-грузовой: '
             wagon_type = gets.chomp.to_i
             case wagon_type
             when 1
               wp = WagonPassenger.new(wagon_number)
               puts "Добавлен пассажирский вагон №#{wagon_number}"
               break
             when 2
               wc = WagonCargo.new(wagon_number)
               puts "Добавлен грузовой вагон №#{wagon_number}"
               break
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
  0.  Выход )
        print 'Выберите  из списка номер задачи: '
        choice = gets.chomp.to_i
        case choice
        when 0 #Выход на верхний уровень
          puts 'Выход в верхнее меню'
          break
        when 1 #Добавление/о   loop do
          train = output_train
             loop do
              print '1-добавить вагон, 2-отцепить вагон: '
              choice = gets.chomp.to_i
              case choice
              when 1
                print 'Введите № вагона: '
                wagon_number = gets.chomp
                if find_wagon(wagon_number).nil?
                  puts 'Такого вагона нет!'
                  break
                end
                wagon = find_wagon(wagon_number)
                train.add_wagon(wagon)
                wagon.train=train
                puts "К поезду №#{train.number} добавлен вагон №#{wagon.number} типа #{wagon.type}"
                break
              when 2
                print 'Введите № вагона: '
                wagon_number = gets.chomp
                if find_wagon(wagon_number).nil?
                  puts 'Такого вагона нет!'
                    break
                end
                wagon = find_wagon(wagon_number)
                train.remove_wagon(wagon)
                wagon.train=nil
                puts "От поезду №#{train.number} отцеплен вагон №#{wagon.number} типа #{wagon.type}"
                break
              end
            end
          # end
        when 2 #Увеличить/уменьшить скорость поезда
        end
      end
    when 3 #Переместить поезд по маршруту
    end
  end
end
 start
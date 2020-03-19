require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
# require_relative 'wagon'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

print 'Выберите один из предложенных вариантов: '
puts %Q(
1.  Добавление станции
2.  Добавление поезда
3.  Создание маршрута
4.  Назначение маршрута поезду
5.  Добавление вагона к поезду
6.  Отцепить вагон от поезда
7.  Перемещение поезда вперед
8.  Перемещение поезда назад
9.  Просмотр списка станций
10. Просмотр списка поездов на станции
0.  Выход
)

loop do
  print 'Выберите номер: '
  choice = gets.chomp.to_i
  case choice
  when 0 #Выход из loop
    puts 'Работа закончена.'
    break
  when 1 #Добавление станции
    print 'Введите название станции: '
    station_name = gets.chomp.to_s
    Station.new(station_name)
    puts   "Добавлена станция #{station_name}"
  when 2 #Добавление поезда
    print 'Введите номер поезда: '
    train_number = gets.chomp.to_s
    p Train.all_trains.map{ |train| train.number == train_number }
    if Train.all_trains.map{ |train| train.number == train_number }.include?train_number2
      puts 'Такой номер поезда уже есть.'
    else
      print 'Какой поезд? 1-пассажирский/2-грузовой: '
      train_type = gets.chomp.to_i
      case train_type
      when 1
        TrainPassenger.new(train_number)
      when 2
        TrainCargo.new(train_number)
      else
        puts 'Введите 1 или 2'
      end
    end


    # p m
  end
end
wgc1 = WagonCargo.new
puts wgc1
wgp1 = WagonPassenger.new
puts wgp1


tc1 = TrainCargo.new(01)
tp1 = TrainPassenger.new(02)

tc1.add_wagon(wgc1)
p tc1
tp1.add_wagon(wgc1)
p tp1
p Train.all_trains


# tc1.increase_speed(10)
# p tc1.current_speed
# tp1.increase_speed(20)
# p tp1.current_speed

tp1.increase_speed(20)
# tr3 = Train.new(03,'gruz')
# tr4 = Train.new(04,'vip')
#
# st1 = Station.new('first')
# st2 = Station.new('second')
# st3 = Station.new('third')
# st4 = Station.new('last')
#
#
# ro1 = Route.new(st1, st4)
# ro1.add_station(st2)
# ro1.add_station(st3)
# tr1.route=ro1
# tr2.route=ro1


# tr1.increase_speed(10)
# tr1.move_forward
# tr1.move_forward
# tr1.move_forward
# tr2.increase_speed(10)
# tr2.move_forward
# tr2.move_forward
# st3.to_s
# st4.to_s


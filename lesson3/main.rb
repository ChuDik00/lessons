require_relative 'station'
require_relative 'route'
require_relative 'train'
require_relative 'train_cargo'
require_relative 'train_passenger'
require_relative 'wagon_cargo'
require_relative 'wagon_passenger'

tr1 = Train.new(01,'pass', '20')
tr2 = Train.new(02,'pass', '15')
tr3 = Train.new(03,'gruz', '40')
tr4 = Train.new(04,'vip', '10')

st1 = Station.new('first')
st2 = Station.new('second')
st3 = Station.new('third')
st4 = Station.new('last')


ro1 = Route.new(st1, st4)
ro1.add_station(st2)
ro1.add_station(st3)
tr1.route=ro1
tr2.route=ro1


tr1.increase_speed(10)
tr1.move_forward
tr1.move_forward
tr1.move_forward
tr2.increase_speed(10)
tr2.move_forward
tr2.move_forward
st3.to_s
st4.to_s


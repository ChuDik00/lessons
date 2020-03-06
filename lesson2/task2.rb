# Fill the array with numbers from 10 to 100 in increments of 5

#Одно из решений по урокам с циклами
array =[]
i = 10
while i <= 100
  array << i
  i += 5
end
p array

#Более компактное решение
array1 = (10..100).step(5).to_a
p array1
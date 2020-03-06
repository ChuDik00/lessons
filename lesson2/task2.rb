# Fill the array with numbers from 10 to 100 in increments of 5

#Одно из решение по урокам с циклами
array =[]
i = 10
while i <= 100 do
  array << i
  i += 5
end

#Более компактное решение
array1 = (10..100).step(5).to_a

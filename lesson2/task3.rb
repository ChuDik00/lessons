# Fibonacci numbers

array = [0, 1]
i = 2
loop do
  new_fib = array[-1] + array[-2]
  break if new_fib >= 100
  array.push(new_fib)
  i += 1
end
p array


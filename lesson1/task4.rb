# Quadratic equation

print 'Enter the 1st coefficient of the algebraic equation (a): '
a = gets.chomp.to_f
print 'Enter the 2nd coefficient of the algebraic equation (b): '
b = gets.chomp.to_f
print 'Enter the 3rd coefficient of the algebraic equation (c): '
c = gets.chomp.to_f
d = b**2 - 4 * a * c
if d.negative?
  puts "Discriminant D = #{d}; no answer!"
elsif d.positive?
  x1 = (-b + Math.sqrt(d))/(2 * a)
  x2 = (-b - Math.sqrt(d))/(2 * a)
  puts "Discriminant D = #{d}; answer Х1 = #{x1}; answer Х2 = #{x2}"
else
  x = -b/(2 * a)
  puts "Discriminant D = #{d}; answer Х = #{x}"
end

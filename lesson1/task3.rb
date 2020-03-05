# Right triangle

print 'Enter the 1st side of the triangle:  '
side_a = gets.chomp.to_f
print 'Enter the 2nd side of the triangle: '
side_b = gets.chomp.to_f
print 'Enter the 3rd side of the triangle: '
side_c = gets.chomp.to_f
a = [side_a, side_b, side_c].sort!
dup = a.length - a.uniq.length
if a[2]**2 == a[0]**2 + a[1]**2
  if dup == 0
    puts 'This is not an isosceles right triangle.'
  else
    puts 'This is an isosceles right triangle.'
  end
else
  if dup == 3
    puts 'This is an equilateral and isosceles not right triangle.'
  elsif dup == 2
    puts 'This is an isosceles and not right triangle.'
  else
    puts 'It is not equilateral and not right triangle.'
  end
end


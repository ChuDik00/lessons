# Ideal Weight

print 'Enter your name: '
name = gets.chomp
name.capitalize!
print 'Enter your height: '
height = gets.chomp.to_i
ideal_weight = (height - 110) * 1.15
if ideal_weight.negative?
  puts "Hello, #{name}, your weight is optimal!"
else
  puts "Hello, #{name}, your optimal weight = #{ideal_weight} kg"
end

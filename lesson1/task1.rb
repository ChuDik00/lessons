# Программа "Идеальный вес"

print "Введите своё имя: "
name = gets.chomp
name.capitalize!
print "Введите свой рост в см.: "
height = gets.chomp.to_i
ideal_weight = (height - 110) * 1.15
if ideal_weight < 0
	puts "Приветствую, #{name}, ваш вес уже оптимальный"
else
	puts "Приветствую, #{name}, ваш идеальный вес = #{ideal_weight} кг."
end

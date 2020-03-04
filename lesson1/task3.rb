# Программа "Прямоугольный треугольник"

print "Введите 1-ю сторону треугольника: "
first = gets.chomp.to_f
print "Введите 2-ю сторону треугольника: "
second = gets.chomp.to_f
print "Введите 3-ю сторону треугольника: "
third = gets.chomp.to_f

if first == second && second == third
	puts "Треугольник равнобедренный и равносторонний, но не прямоугольный"
else
	if first > second && first > third
		if first**2 == second**2 + third**2
		 	if second == third
		 		puts "Треугольник прямоугольный, равнобедренный"
	  	else
		 		puts "Треугольник прямоугольный, неравнобедренный"
	  	end
		else
		 	if second == third
		 		puts "Треугольник не прямоугольный, равнобедренный"
		 	else
		 		puts "Треугольник не прямоугольный, не равнобедренный"
			end
		end
	elsif second > first && second > third
		if second**2 == first**2 + third**2
			if first == third
		 		puts "Треугольник прямоугольный, равнобедренный"
		 	else
		 		puts "Треугольник прямоугольный, неравнобедренный"
		 	end
		else
		 	if first == third
		 		puts "Треугольник не прямоугольный, равнобедренный"
		 	else
				puts "Треугольник не прямоугольный, не равнобедренный"
			end
		end
	elsif third > first && third > second
		if third**2 == first**2 + second**2
			if first == second
		 		puts "Треугольник прямоугольный, равнобедренный"
		 	else
		 		puts "Треугольник прямоугольный, неравнобедренный"
		 	end
		else
			if first == second
			 	puts "Треугольник не прямоугольный, равнобедренный"
			else
			 	puts "Треугольник не прямоугольный, не равнобедренный"
			end
		end
	end
end
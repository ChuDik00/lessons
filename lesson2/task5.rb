# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.

#Решение с хэшем, но так же можно и с массивом (с хэшем как то более наглядно)
months_days = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
      7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }
print 'Enter YEAR: '
year = gets.chomp.to_i
return puts 'The YEAR must be positive.' if year.negative? || year == 0
months_days[2] = 29 if (year % 400).zero? || (year % 4).zero? && (year % 100) != 0
print 'Enter MONTH: '
month = gets.chomp.to_i
return puts 'The MONTH must be between 1 and 12.' if !(1..12).include?(month)
print 'Enter DAY: '
day = gets.chomp.to_i
return   puts "For the #{year} year of the #{month} month, the DAY should be between 1 and #{months_days[month]}." if !(1..months_days[month]).include?(day)
date = months_days.values.take(month-1).sum + day
puts "Date number from the beginning of the year = #{date}"



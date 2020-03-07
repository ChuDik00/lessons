# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.

h = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
      7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }
date = 0

print 'Enter YEAR: '
year = gets.chomp.to_i
if year.negative? || year == 0
  puts 'The year must be positive.'
else
  if (year % 100).zero? && (year % 400).zero?
    h[2] = 29
  elsif  (year % 4).zero? && (year % 100) != 0
    h[2] = 29
  else
  end
  print 'Enter MONTH: '
  month = gets.chomp.to_i
  if !(1..12).include?(month)
    puts 'The month must be between 1 and 12.'
  else
    print 'Enter DAY: '
    day = gets.chomp.to_i
    if !(1..h[month]).include?(day)
      puts "For the #{year} year of the #{month} month, the day should be between 1 and #{h[month]}."
    else
      for i in 1..month do
        date += h[i]
      end
      date = date - h[month] + day
      puts "Date number from the beginning of the year = #{date}"
    end
  end
end


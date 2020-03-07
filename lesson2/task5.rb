# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.

months_days = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
      7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }
date = 0

print 'Enter YEAR: '
year = gets.chomp.to_i
if year <= 0
  puts 'The YEAR must be positive.'
else
  if (year % 100).zero? && (year % 400).zero?
    months_days[2] = 29
  elsif  (year % 4).zero? && (year % 100) != 0
    months_days[2] = 29
  end
  print 'Enter MONTH: '
  month = gets.chomp.to_i
  if !(1..12).include?(month)
    puts 'The MONTH must be between 1 and 12.'
  else
    print 'Enter DAY: '
    day = gets.chomp.to_i
    if !(1..months_days[month]).include?(day)
      puts "For the #{year} year of the #{month} month, the DAY should be between 1 and #{months_days[month]}."
    else
      for i in 1..month do
        date += months_days[i]
      end
      date = date - months_days[month] + day
      puts "Date number from the beginning of the year = #{date}"
    end
  end
end


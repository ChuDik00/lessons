# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года.
# Учесть, что год может быть високосным.

months_days = { 1 => 31, 2 => 28, 3 => 31, 4 => 30, 5 => 31, 6 => 30,
      7 => 31, 8 => 31, 9 => 30, 10 => 31, 11 => 30, 12 => 31 }
print 'Enter YEAR: '
year = gets.chomp.to_i
if year <= 0
  puts 'The YEAR must be positive.'
else
  months_days[2] = 29 if (year % 400).zero? || (year % 4).zero? && (year % 100) != 0
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
      date = 0
      (month-1).times { |i| date += months_days[i+1] }
      date += day
      puts "Date number from the beginning of the year = #{date}"
    end
  end
end
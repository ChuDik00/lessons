# Заполнить хеш гласными буквами, где значением будет являться
# порядковый номер буквы в алфавите (a - 1).

alphabet = "абвгдеёжзийклмнопрстуфхцчшщъыьэюя".each_char.to_a
wovels = "аеёиоуыэюя".each_char.to_a
hash = {}
wovels.each do |letter|
  index = alphabet.index letter
  hash[letter] = index+1
end
p hash

def sing(num)
	num = num.to_i

	while num > 0

		next_num = num - 1
		puts "#{num} bottles of beer on the wall, #{num} bottles of beer,
take one down, pass it around, #{next_num} bottles of beer on the wall."

		num = next_num

		if num == 1
			puts "#{num} bottle of beer on the wall, #{num} bottle of beer,
take one down, pass it around, no bottles of beer on the wall."
			return
		end
	end

end

puts "How many bottles of beer are on the wall?"
num = gets.chomp

puts sing(num)
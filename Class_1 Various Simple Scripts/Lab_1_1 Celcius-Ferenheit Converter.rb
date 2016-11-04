
def convert_temp ()
	
	puts "What's your temperature"
	temp = gets.chomp

	temp = temp.to_i #Could also do in-place assignment, but didnt.

	puts "Is that Farenheit (f) or celsius (c)?"
	scale = gets.chomp


	if scale == 'c' then
		new_temp = temp*(9/5) + 32
		puts "I made it to c"
		return new_temp
	elsif scale == 'f' then
		new_temp = (temp-32) * 5/9
		puts "I made it to f"
		return new_temp	
	else
		puts 'You forgot to say whether your temperature was farenheit or celcisu wanted'
	end

end



puts convert_temp()

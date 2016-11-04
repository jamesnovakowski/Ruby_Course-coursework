def name_age ()
	puts "What's your name?"
	name = gets.chomp

	puts "What's your age"
	age = gets.chomp.to_i

	time = Time.new

	puts time
	puts time.year

	puts "Check 1"

	birth_year = time.year - age

	puts "Check 2"

	puts "#{name} was born in #{birth_year}."
end

puts name_age()

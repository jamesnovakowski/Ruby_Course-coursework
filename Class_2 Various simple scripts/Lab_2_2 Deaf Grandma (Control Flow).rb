def grandma_doesnt_hear()
	puts "HUH?! SPEAK UP SONNY!"
	return gets.chomp
end

def grandma_hears()
	year = rand(1930..1980)
	puts "NO, NOT SINCE #{year}."
	puts "WHAT ELSE?"
	return gets.chomp
end


def deaf_grandma ()

	puts "What do you want to say to Grandma?"
	say = gets.chomp

	while say != "BYE" or say != "BYE!"

		if say == say.upcase
			say = grandma_hears()
		else
			say = grandma_doesnt_hear()
		end
	end

	puts "OKAY! BYE SONNY!"
end

puts deaf_grandma()
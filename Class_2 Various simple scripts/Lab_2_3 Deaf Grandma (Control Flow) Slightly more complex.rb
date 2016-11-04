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

	bye_count = 0

	while (say != "BYE" or say != "BYE!") and bye_count < 3

		if say == "BYE" or say == "BYE!"
			bye_count = bye_count + 1
			puts "I'D RATHER YOU DIDN'T GO!"
		elsif say == say.upcase
			say = grandma_hears()
			bye_count = 0
		else
			say = grandma_doesnt_hear()
			bye_count = 0
		end
	end

	puts "OKAY! BYE SONNY!"
end

puts deaf_grandma()
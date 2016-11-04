
class SuspectList
	def initialize
		@suspects = Array.new
		@gender_list = Array.new
		@skin_list = Array.new
		@hair_list = Array.new
		@eye_list = Array.new

		list = File.open('C:\Users\James\Desktop\Ruby Course\Class_5\Suspects.txt.txt')

		for line in list
			name, gender, skin, hair, eye = line.split

			if !@gender_list.include? gender
				@gender_list.push(gender)
			end

			if !@skin_list.include? skin
				@skin_list.push(skin)
			end

			if !@hair_list.include? hair
				@hair_list.push(hair)
			end

			if !@eye_list.include? eye
				@eye_list.push(eye)
			end

			@suspects.push(Suspect.new(name, gender, skin, hair, eye))
		end

		@the_suspect = @suspects.sample
	end

	attr_reader(:suspects, :gender_list, :skin_list, :hair_list, :eye_list)

	def current_suspects
		puts "Name\tGender\tSkin\tHair\tEye Color"
		for suspect in @suspects
			# name = suspect.name
			# gender = suspect.gender
			# skin = suspect.skin_color
			# hair = suspect.hair_color
			# eye = suspect.eye_color

			puts "#{suspect.name}\t#{suspect.gender}\t#{suspect.skin_color}\t#{suspect.hair_color}\t#{suspect.eye_color}"
		end
	end

	def check_feature(feature, char)
		if feature == "gender"
			if char != @the_suspect.gender
				guess = false
				chars = [char]
			else
				guess = true
				chars = @gender_list
				chars.delete(char)
			end
		elsif feature == "skin color"
			if char != @the_suspect.skin_color
				guess = false
				chars = [char]
			else
				guess = true
				chars = @skin_list
				chars.delete(char)
			end
		elsif feature == "hair color"
			if char != @the_suspect.hair_color
				guess = false
				chars = [char]
			else
				guess = true
				chars = @hair_list
				chars.delete(char)
			end
		elsif feature == "eye color" 
			if char != @the_suspect.eye_color
				guess = false
				chars = [char]
			else
				guess = true
				chars = @eye_list
				chars.delete(char)
			end
		else
			puts "Something went wrong with identifying the suspect. (check_feature)"
		end

		remove_suspects(feature, chars)

		if guess 
			puts "You are correct! The suspect's #{feature} is #{char}"
		else 
			puts "No, the suspect's #{feature} is NOT #{char}."
		end

	end

	def num_suspects
		@suspects.length
	end

	#removes suspects based on the characteristic of the indentifying feature.

	def guess_suspect(name)
		names = Array.new
		for suspect in @suspects
			names.push(suspect.name)
		end

		while !names.include? name
			puts "\n-----------------------------------------------"
			puts "I'm sorry, #{name} is not one of the current suspects. Try again"
			self.current_suspects
			name = gets.chomp.downcase
		end

		if name == @the_suspect.name
			puts "\n-----------------------------------------------"
			puts "You're RIGHT! The suspect is #{name}!"
		else
			puts "\n-----------------------------------------------"
			puts "Sorry, the suspect was #{@the_suspect.name}."
			puts "Better luck next time."
		end
	end

	private 
	def remove_suspects(feature, char)
		
		if feature == "gender"
			@suspects.delete_if {|suspect| char.include? suspect.gender}
		elsif feature == "skin color"
			@suspects.delete_if {|suspect| char.include? suspect.skin_color}
		elsif feature == "hair color"
			@suspects.delete_if {|suspect| char.include? suspect.hair_color}
		elsif feature == "eye color" 
			@suspects.delete_if {|suspect| char.include? suspect.eye_color}
		else
			puts "Feature not recognized.  You suck at this game."
		end
	end
end

class Suspect
	def initialize (name, gender, skin, hair, eye)
		@name = name
		@gender = gender
		@skin_color = skin
		@hair_color = hair
		@eye_color = eye
	end

	attr_reader(:name, :gender, :skin_color, :hair_color, :eye_color)
end

class Game
	def initialize
		@suspects = SuspectList.new
	end
	
	def play

		game_play = true

		while game_play
			puts "-----------------------------------------------"
			puts "Welcome to the game of Guess Who!"
			puts "-----------------------------------------------"
			puts "\nThe object of the game is to guess a suspect"
			puts "from a list of suspects based on their physical"
			puts "features.  Shall we begin? (y/n)"
			ans = gets.chomp.downcase[0]

			if ans=="y"
				puts "\n-----------------------------------------------"
				puts "Great!  Let's do this!"
			else 
				puts "\n-----------------------------------------------"
				puts "Fine, be that way."
				break
			end

			guess_count = 0
			while guess_count < 3
				puts "\n-----------------------------------------------"
				puts "-----------------------------------------------"
				puts "Your suspect list is as follows:"
				@suspects.current_suspects

				puts "\n-----------------------------------------------"
				puts "-----------------------------------------------"
				puts "What feature would you like ask about?"
				puts "(G)ender, (S)kin color, (H)air Color, (E)ye Color"
				feature = gets.chomp.downcase[0]
				while !(["g","s","h","e"].include? feature)
					puts "\n-----------------------------------------------"
					puts "I'm sorry, which feature would you like to use?"
					feature = gets.chomp.downcase[0]
				end

				if feature == "g"
					feat = "gender"
					items = @suspects.gender_list
					puts
				elsif feature == "s"
					feat = "skin color"
					items = @suspects.skin_list
				elsif feature == "h"
					feat = "hair color"
					items = @suspects.hair_list
				elsif feature == "e"
					feat = "eye color"
					items = @suspects.eye_list
				end

				puts "\n-----------------------------------------------"
				puts "Cool, which #{feat} would you like to guess?"
				
				for item in items
					puts item
				end

				char = gets.chomp.downcase
			

				while !items.include? char
					puts "\n-----------------------------------------------"
					puts "I'm sorry, no suspect's #{feat} is #{char}."
					puts "Which #{feat} would you like to guess?"
					for item in items
						puts item
					end
					char = gets.chomp.downcase
				end

				@suspects.check_feature(feat, char)
				guess_count += 1

				if @suspects.num_suspects == 1
					break
				end
				
			end

			if @suspects.num_suspects == 1
				puts "\n-----------------------------------------------"
				puts "Wow, you've figured out the culprit! It's #{@suspects.suspects[0].name}"
			else
				puts "\n-----------------------------------------------"
				puts "The only suspects left are:"
				@suspects.current_suspects
				puts "\n-----------------------------------------------"
				puts "Go ahead, guess who it is. Follow your gut.  Who is it? (name)"
				name = gets.chomp.downcase
				@suspects.guess_suspect(name)
			end

			puts "\n-----------------------------------------------"
			puts "Would you like to play again?"
			play = gets.chomp.downcase[0]

			unless play == "y"
				break
			end 

		end

		puts "Thanks for Playing Guess Who!"
	end

end

game = Game.new
game.play
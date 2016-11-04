$testing = false #Sets condition to include/exclude checkpoint

class League
	def initialize (league = "NFL")
		@name = league
		@teams = Array.new
		@teams_ranked = false
	end

	attr_accessor :name

	def set_name(name)
		@name = name
	end

	#Provides table of whole league, ranked from highest to lowest sore
	#Tied scores are sorted alphabetically ascending.
	def league_ranks
		#rank teams
		self.rank

		puts "Rank : Team Name : League Score"
		
		#return or print the ranked league
		@teams.each do |team|
			puts "##{team.rank} : #{team.name} : #{team.score}" 
		end
	end

	#Provide rank of a single team based, based on team name.
	def team_rank
		self.rank
		i = nil

		puts "Which team would you like to look up?"
		team_name = gets.chomp.downcase

		while i == nil
			i = @teams.index {|team| team.name.downcase == team_name}
			if i == nil
				puts "I'm sorry, which team's score would you like?"
				team_name = gets.chomp.downcase
			end
		end

		team = @teams[i]
		puts "Rank : Team Name : League Score"
		puts "#{team.rank} : #{team.name} : #{team.score}"

	end

	#Allows user to input the scores from a game, then computes the league scores
	#from the game
	def input_game(string)
		#split incoming string into teams, scores
		input_array = string.split

		if $testing
			puts "Checkpoint: after splitting input array"
			puts input_array
		end

		#THIS IS UGLY (maybe?  It works, though...)
		reg = /(?:\d)/ #regular expression to look for numbers
		#work over input array to make it a 4 item array structured:
		#[team1_name, team1_score, team2_name, team2_score]
		output_array = Array.new
		input_array.each_index do |item|
			if !reg.match(input_array[item])
				if !reg.match(input_array[item-1])
					input_array[item] = "#{input_array[item-1]} #{input_array[item]}"
					if $testing
						puts input_array
					end
				end
			else
				output_array.push(input_array[item-1])
				output_array.push(input_array[item])
			end
		end

		if $testing
			puts "Checkpoint: Input Game Formatted to 4 item array?"
			puts output_array
		end

		teams = Hash.new

		#check to see which team won, assign league points
			#consider how you might change this if ranking more than 2 teams.  Or not.
		if output_array[1] == output_array[3]
			teams[output_array[0]] = 1
			teams[output_array[2]] = 1
		elsif output_array[1] > output_array[3]
			teams[output_array[0]] = 3
			teams[output_array[2]] = 0
		elsif output_array[1] < output_array[3]
			teams[output_array[0]] = 0
			teams[output_array[2]] = 3
		else
			puts "Checkpoint : Game Outcome check"
			puts teams
		end

		#add league points to each team's league score
		teams.each do |name, score|
			self.add_score(name, score) #may not need to reference an object. Just call method?
		end
	end

	#private 

	#for some reason, I found these private methods to be inaccessible
	#when I called them from within an instance of the class.  maybe I did something wrong?

	def add_score(name,score)
		i = @teams.index {|team| team.name == name} 		
		if i == nil
			@teams.push(Team.new(name,score))
		else
			@teams[i].add_score(score)
		end

		@teams_ranked = false
	end
			
	def rank
		#sort the teams based on league scores, team name as tie-breaker (Score highest->lowest, name lowest -> highest)

		#Sort by Multiple Attributes (why does this work? Review)
		#source:http://stackoverflow.com/questions/882070/sorting-an-array-of-objects-in-ruby-by-object-attribute
		if !@teams_ranked
			@teams.sort! { |a,b| (a.score == b.score) ? a.name.downcase <=> b.name.downcase : b.score <=> a.score }
		end
		#NOTE: Upper case has alphabet has lower value than lower case alphabet.  Good to know.

		#set rank of each team
		if !@teams_ranked
			i = 1
			@teams.each do |team|
				if $testing
					puts "Checkpoint : team value in rank block"
					puts team
				end
				team.rank=i
				i += 1
			end
		end

		@teams_ranked = true

	end

end

class Team
	#League Score
	def initialize(name,score=0)
		@name = name
		@score = score
		@rank = nil
	end

	def add_score(score)
		@score += score
	end

	#getter and setter methods
	attr_reader(:name, :score)
	attr_accessor(:rank)
end

class Input
	
	def initialize
		@league = League.new
	end

	attr_accessor :league
	
	def user_interact
		#should be a loop that accepts user input until... whenver they want to quit.
		puts "----------------------------------------------"
		puts "Hello and welcome to the League Calculator"
		puts "You will be asked to enter the results of"
		puts "games from a given league."
		puts "----------------------------------------------"
		puts "----------------------------------------------"

		puts "----------------------------------------------"
		puts "Which league are you collecting information for?"
		league = gets.chomp.downcase
		@league.set_name(league)
		user_input = nil

		games = File.open('C:\Users\James\Desktop\Ruby Course\Class_6\Games.txt')
		games.each do |line|
			@league.input_game(line)
		end

		while user_input != "quit"
			puts "\n----------------------------------------------"
			puts "----------------------------------------------"
			puts "Would you like to add the outcomes of games (games),"
			puts "get the full league rankings (rank)"
			puts "or check the ranking of a single team (team)?"
			puts "((g)ame/(r)ank/(t)eam)"
			user_input = gets.chomp
			
			if user_input == "quit"
				break 
			elsif user_input[0] == "g"
				puts "----------------------------------------------"
				puts "Great, what are the team scores?"
				puts "(input as single string, Team_1 Team_1_score Team_2 Team_2_Score)"
				game_results = gets.chomp
				@league.input_game(game_results)
			elsif user_input[0] == "r"
				@league.league_ranks
			elsif user_input[0] == "t"
				@league.team_rank
			else
				puts "\n----------------------------------------------"
				puts "I'm sorry, I don't undersatnd."
			end
		end
	end
end


league = Input.new
league.user_interact
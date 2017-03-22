"""
The following script was developed for an introductory ruby course.
It implements basic BlackJack rules in a text-based game, and permits 
the user to bet on each round of play as it is played. 

The game terminates when the user runs out of money, or chooses to exit 
the game at the end of a round of play.
"""


class BlackJack
	
	def initialize()
		#initialize deck
		@deck_1 = Deck.new
		#initialize player
		@player_1 = Player.new

		#initialize Dealer
		@dealer_1 = Dealer.new

		@gamestate = true
	end

	def play()
		@gamestate = true
		deck_1 = @deck_1
		player_1 = @player_1
		dealer_1 = @player_1
		game_num = 1

		while @gamestate
			
			#Opening the game
			name = @player_1.name
			if game_num == 1
				puts "Welcome to the table, #{name}.  The name of the game is Blackjack. \nThe goal is to reach 21."
				puts "Table Rules: Aces Low, no side bets, no splits, no double up. \nKeep it simple, stupid."
			else 
				puts "Alright #{name}, let's play."
			end

			#deal to player, deal to dealer
			#puts "Dealing Player"
			@player_1.deal(@deck_1)
			#puts "Dealing Dealer"
			@dealer_1.deal(@deck_1)

			#player turn

			# catch :over_21
				p_total = @player_1.total
				p_hand = @player_1.hand
				d_hand = @dealer_1.hand
				d_total = @dealer_1.total
				d_shows = @dealer_1.visible_hand.id
				d_show_value = @dealer_1.visible_hand.value
				p_cash = player_1.bankroll

				puts "You have $#{p_cash}. How much would you like to bet this round?"
				bet = gets.chomp.to_i

				while bet > player_1.bankroll
					puts "I'm sorry, you don't have that much money. Try another value."
					bet = gets.chomp.to_i
				end

				if bet < player_1.bankroll
					puts "Your bet of $#{bet} is accepted"
				elsif bet = player_1.bankroll 
					puts "You've gone all-in. Do you feel lucky, punk? Do ya?"
					gets.chomp
				end

				player_1.bet(bet)

				puts "The dealer deals."

				puts "The dealer is showing #{d_shows}, for value of #{d_show_value}"
				puts "You have: #{p_hand}"
				puts "For a total of #{p_total}"
				puts "What would you like to do? Hit (h) or Stay (s)"
				act = gets.chomp.downcase

				
				while act[0] != "s"
					if act[0] == "h"
						p_total, p_card = @player_1.hit(deck_1)
						puts "#{p_card}"
						puts "Your total is #{p_total}"
						if p_total > 21
							puts "I'm sorry, you've gone bust.  Better luck next time."
							break
						end
						puts "What would you like to do? Hit (h) or Stay (s)?"
						act = gets.chomp.downcase
					else					 	 
						puts "Sorry, what did you want to do?"
						act = gets.chomp.downcase
					end

					# if p_total > 21
					# 	puts "I'm sorry, you've lost this round"
					# 	# throw(:over_21)
					# 	act = "s"
					# end
				end

				if p_total <= 21 
					puts "Now it's the dealer's turn"
					puts "The dealer turns over their second card to reveal " + @dealer_1.hand
					puts "The dealer's total is #{d_total}"
					gets.chomp
					
					while d_total < 17 
						puts "The dealer hits"
						d_total, d_card = @dealer_1.hit(@deck_1)
						puts d_card
						puts "The dealer has #{d_total}."
						gets.chomp
					end

					if @dealer_1.total == @player_1.total
						puts "You and the dealer tie.  Your bet of #{bet} is returned to you"
						@player_1.collect(bet)
					elsif @dealer_1.total > 21
						puts "The dealer busted.  You WIN!"
						@player_1.collect(2*bet)
					elsif @dealer_1.total > @player_1.total
						puts "The dealer had #{d_total} and you had #{p_total}.  Better luck next time"
					else 
						puts "You had #{p_total} and the dealer had #{d_total}.  You win!"
						@player_1.collect(2*bet)
					end
				end
			# end

			@player_1.reset
			@dealer_1.reset

			#puts "Shuffle Check" # This is a debugging checkpoint
			deck_check = @deck_1.cards_played
			prop_check = ((@deck_1.cards_played)/52.0)

			#puts "Card Count = #{deck_check}, proportion = #{prop_check}" #this is a debugging checkpoint

			if ((@deck_1.cards_played)/52.0) > (0.75)
				@deck_1.shuffle
			end


			puts "Would you like to play another round? (y or n)"
			another = gets.chomp.downcase
			gamestate = ("y" == another) #This shoudl cause the condition of the loop to fail, but doesn't.  So I put in the break condition below.
			if another[0] == "n"
				break
			end

			if @player_1.bankroll <= 0
				puts "Sorry, you're out of cash."
				break
			end
			game_num = game_num + 1
			
		end

	puts "Thanks for playing Blackjack.  Come back soon!"
	end 

end

class Deck
	#build deck
	def initialize()
		@deck = Array.new
		@discard_pile = Array.new
		@count_cards = 0

		suit_range = {"Ace" => 1,"2" => 2,"3" => 3,"4" => 4,"5" => 5,"6" => 6,
					  "7" => 7,"8" => 8,"9" => 9,"10" => 10,"Jack" => 10,
					  "Queen" => 10,"King" => 10}
		suits = ["Hearts","Diamonds","Spades","Clubs"]

		for k,v in suit_range
			for s in suits
				@deck.push(Card.new(k,s,v))
			end
		end

		@deck.shuffle!
	end

	def cards_played
		@count_cards
	end

	def deck()
		@deck
	end


	#shuffle deck
	def shuffle()
		@deck = @deck.push(*@discard_pile)
		@deck.shuffle
		#push @deck[0]
		@count_cards = 0
	end

	#deal
	def deal()
		cards = Array.new
		cards.push(hit())  #can we do cards.push.hit()
		cards.push(hit())
		return cards
	end

	#hit
	def hit()
		card = @deck.pop
		@discard_pile.push(card)
		@count_cards += 1
		return card
	end
end

class Card
	def initialize(number, suit, value)
		@number = number
		@suit = suit
		@value = value
	end

	attr_accessor(:number,:suit,:value)

	def id ()
		return (@number + " of " + @suit)
	end

end

class Player
	#Player name
	def initialize()
		puts "What's your name?"
		@name = gets.chomp
		@hand = Array.new
		@total = 0
		puts "How much money do you have?"
		@bankroll = gets.chomp.to_i
	end

	attr_accessor(:name, :total, :bankroll)
	
	def hand()
		h = ""
		for c in @hand
			h = h + c.id + ",\n"
		end
		return h
	end


	def hit(deck)
		card = deck.hit
		@hand.push(card)
		@total += card.value
		#puts card.id
		return @total, card.id
	end

	def deal(deck)
		hit(deck)
		hit(deck)
	end

	def bet(amt)
		@bankroll = @bankroll - amt
	end

	def collect(amt)
		@bankroll = @bankroll + amt
	end

	#Reset Total  #do we need this? OH, yes, we do.
	def reset
		@hand = Array.new
		@total = 0
	end

end

class Dealer < Player
	def initialize()
		@name = "Dealer"
		@hand = Array.new
		@total = 0
	end

	def visible_hand
		@hand[0]
	end

end

if __FILE__ == $0
  # Put "main" code here
  new_game = BlackJack.new()
  new_game.play
end
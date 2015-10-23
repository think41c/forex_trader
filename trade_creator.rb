class TradeCreator
	# Just use probabilities to calculate the win or loss for that trade. 
	def trade_gen
		answers = []
		10.times do 
			a = rand(1..100)
			if a < 50    # Percentage of winning trades.
				trade = 1
			else
				trade = -1
			end
			answers << trade
		end
		puts answers
		verify_percentage(answers)
	end

	def verify_percentage(answers)
		win  = 0
		lose = 0 
		answers.each do |x| 
			if x == -1
				lose += 1
			else
				win  += 1
			end
		end
		total = win + lose
		percentage = (win / total.to_f) * 100 
		puts "The percentage of winners is #{percentage.to_i}%"
	end
end
a = TradeCreator.new
a.trade_gen
a.trade_gen
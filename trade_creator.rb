class TradeCreator
	# Just use probabilities to calculate the win or loss for that trade. 
	
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
end

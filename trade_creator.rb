class TradeCreator
	# Just use probabilities to calculate the win or loss for that trade. 
	a = rand(1..100)
	if a < 80    # Percentage of winning trades.
		trade = 1
	else
		trade = -1
	end
	puts trade
end

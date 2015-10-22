class TradeCreator
	# Just use probabilities to calculate the win or loss for that trade. 
	a = rand(1..2)
	if a == 1 
		trade = 1
	else
		trade = -1
	end
	puts trade
end

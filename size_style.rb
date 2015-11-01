class SizeStyle

	def equal_win_and_losers(new_size, trade)
  	profit = new_size * trade
  	profit
	end

  def diff_sized_win_and_losers(new_size, trade)
    if trade == 1
      profit = new_size * trade
    else
      profit = (new_size*0.5) * trade  # Losers only lose half as much
    end
  profit
  end
  
end

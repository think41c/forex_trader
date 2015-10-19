class Forex
  
  def initialize 
    puts "Welcome to Forex trader"
    menu
  end

  def intro 
    puts "This program goes through every possible combination of trades for you."
    puts "You can enter your probability of a successful trade, say 50%, and the program will simulate"
    puts "each combination of X amount of trades that would still provide that probability. Such that in 10 trades you might have 5x"
    puts "winning streak, or never a streak more than 1 winning trade at a time. It will then show with all the potential combinations"
    puts "what the highest amount you could win, as well as the lowest amount you could lose. As the law of big numbers implies, long"
    puts "streaks are possible in any direction, which is the failure of martingale systems."
    puts "Remember the eur/usd and usd/chf are basically the same. AUD/USD & NZD/USD are same too."
  end

  def get_user_data
    puts "How many trades would you like to simulate? 10-20 is allowed."
    @trades = gets.chomp.to_i
    puts "What percentage of trades will you win? 0-100 is allowed."
    @percentage = gets.chomp.to_i
    puts "We presume the exit is equadistant on both the winning and losing exit, therefore profit amounts are same loss amounts."
    puts "What's your initial win/loss dollar amount? 0-100 is allowed."
    @amount = gets.chomp.to_i
    puts "You may want to increase your size if you're winning, meaning you're looking at an anti-martingale system. So:"
    puts "If you have a winning trade, would you like your next position size to be based on a percentage or a fixed amount more or less?"
    puts "(F)ixed or (P)ercentage"
    win_fix_or_perc = gets.chomp
    puts "What amount more or less would it be? (-100 to infinite for percentage or any infinite for fixed)"
    @winner_change = gets.chomp.to_i
    puts "If you have a LOSING trade, would you like your next position size to be based on a percentage or a fixed amount more or less?"
    puts "(F)ixed or (P)ercentage"
    @lose_fix_or_perc = gets.chomp
    puts "What amount more or less would it be? (-100 to infinite for percentage or any infinite for fixed)"
    @loser_change = gets.chomp.to_i
  end

  def define_fixed_wins
    @win_trades = (@percentage.to_f / 100) * @trades
    @win_trades = @win_trades.to_i
  end

  def profits(current_sequence)  # current_sequence is the wins_and_losses genearted from generate_all_trades
  # Takes in current_sequence, an array of 0s and 1s indicating wins and losses and calculates P&L for each.
  # This calculates the amount you would have won/lost for each potential win/loss trade combination possibility.

    current_sequence.each do |x| 
      puts "Looking at this trade -> #{current_sequence[x]}"
      puts "You made #{current_sequence[x] * @amount}"
      puts "****"
    end

    winning_profit_on_this_sequence = @win_trades.to_i * @amount.to_i
    losing_losses_on_this_sequence = @lose_trades.to_i * @amount.to_i
    total_pandl = winning_profit_on_this_sequence - losing_losses_on_this_sequence
    the_profits_for_each_sequence = []
    p winning_profit_on_this_sequence 
    p @win_trades
    p @amount

    puts "With your #{@trades} trades, you won #{@win_trades} times. And made $#{@amount} each winning trade,"
    puts "totalling #{winning_profit_on_this_sequence} in winners and #{losing_losses_on_this_sequence} in losses."
    puts "So your total P&L is #{total_pandl}"
    the_profits_for_each_sequence << total_pandl
  end

  def generate_all_trades
    # N! / (N-R)!   <- Where N is total trades, and R is the possibilities of results which is 2 (either a win or loss)
    # 3! / (3-2)!  --> 3*2 / 1 --> 6
    # 1, 1, 0. || 1,0,1 || 0,1,1
    # ---- These formulas don't work but we'll need a permutation formula eventually ---- 

    number_of_possible_trades = 100 # this where the permutation formula goes
    @lose_trades = @trades - @win_trades
    puts @lose_trades
    wins_and_losses = trade_array
    puts "Here's your wins and losses #{p wins_and_losses}"
    puts "There will be #{@trades} amount of permutations"  # This needs to be permutation calculation ...not a predetermined number.
    # Here we need to deal with every permutation possible of the percentage wins/losses he might have. 
    profits(wins_and_losses)
    # Rearrange the array, and take that array and give it to the 'profits' method to determine what the profits are.
    # Return the answer into an array. 
  end

  def trade_array
    # This is only generated one time. It's the master array we will shuffle around.
    # This takes winning trades and places them in an array as a 1, and losing trades as a 0.
    all_trades = Array.new(@trades)
    # The win_spot is the location in the array where a winning trade will reside initially before shuffled around.
    win_spot = @lose_trades
    lose_spot = 0
    @lose_trades.times do 
      all_trades[lose_spot] = -1
      lose_spot += 1 
    end

    @win_trades.times do
      all_trades[win_spot] = 1
      win_spot += 1
    end
    all_trades
  end


  def menu
    intro
    get_user_data
    define_fixed_wins
    generate_all_trades
  end
end

a = Forex.new
a
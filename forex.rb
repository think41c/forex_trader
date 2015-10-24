# Does not currently operate with percentages. Fixed amounts only. And martingale only currently.
require './trade_creator.rb'

class Forex
  
  def initialize 
    get_sequences = TradeCreator.new
    puts "Welcome to Forex trader"
    menu
  end


  def profits(current_sequence)  # current_sequence is the trade_array genearted from generate_all_trades
  # Takes in current_sequence, an array of 0s and 1s indicating wins and losses and calculates P&L for each.
  # This calculates the amount you would have won/lost for each potential win/loss trade combination possibility.
    amount_to_trade_for_this_sequence = @amount
    the_profits_for_each_sequence     = []
    puts "Running the TradeCreator"
    get_sequences.trade_gen
    puts "Running the TradeCreator"
    current_sequence.each_with_index do |win_or_lose, index| 
      puts "Looking at this trade -> #{current_sequence[index]}"
      this_trades_pandl = current_sequence[index] * amount_to_trade_for_this_sequence  # -1 or 1 * the amount traded
      puts "You made/lost #{this_trades_pandl}"
      
      # Figure up the next position size if you won
      if @win_fix_or_perc == "f" 
        if current_sequence[index] == 1
          puts "Winner stuff here"
          amount_to_trade_for_this_sequence += @winner_change
        end
      end

      # Figure size for losers
      puts "What's current_sequence[index] == #{current_sequence[index]}"
      if current_sequence[index] == -1 
        if @lose_fix_or_perc == "s"   # This should start over the amount to default beginning trade size
          amount_to_trade_for_this_sequence = @amount
          puts "Loser stuff here - going back to trade only #{@amount}"
        end

        if @lose_fix_or_perc == "f"
          amount_to_trade_for_this_sequence += @loser_change
          puts "Loser - trading now #{amount_to_trade_for_this_sequence}"
        end

      end

      puts "****"
      the_profits_for_each_sequence << this_trades_pandl
    end
    puts "The total profits for this sequence was #{the_profits_for_each_sequence}"
    puts "The total profits for this sequence was #{the_profits_for_each_sequence.inject(:+)}"
    the_profits_for_each_sequence.inject(:+)
  end

  def generate_all_trades
    # N! / (N-R)!   <- Where N is total trades, and R is the possibilities of results which is 2 (either a win or loss)
    # 3! / (3-2)!  --> 3*2 / 1 --> 6
    # 1, 1, 0. || 1,0,1 || 0,1,1
    # ---- These formulas don't work but we'll need a permutation formula eventually ---- 

    number_of_possible_trades = 100 # this where the permutation formula goes
    @lose_trades = @trades - @win_trades
    full_trade_array = trade_array
    puts "Here's your wins and losses #{full_trade_array}"
    puts "There will be #{number_of_possible_trades} amount of permutations"  # This needs to be permutation calculation ...not a predetermined number.
    # Here we need to deal with every permutation possible of the percentage wins/losses he might have. 
    # profits(full_trade_array)   #  <--- Use this normally
    the_total_profits_of_all_sequences = []
    the_total_profits_of_all_sequences << profits([-1,-1,-1,1,1,-1,-1,1,1,1]) #  <--- this is a stubbed array for 50% wins for 10 trades
    the_total_profits_of_all_sequences << profits([-1,1,-1,1,1,-1,-1,-1,1,1]) #  <--- this is a stubbed array for 50% wins for 10 trades
    the_total_profits_of_all_sequences << profits([-1,-1,-1,1,1,1,-1,-1,1,1]) #  <--- this is a stubbed array for 50% wins for 10 trades
    the_total_profits_of_all_sequences << profits([-1,-1,-1,1,1,1,-1,1,1,-1]) #  <--- this is a stubbed array for 50% wins for 10 trades
    the_total_profits_of_all_sequences << profits([-1,1,1,1,1,-1,-1,1,-1,-1]) #  <--- this is a stubbed array for 50% wins for 10 trades
    the_total_profits_of_all_sequences << profits([-1,-1,-1,-1,-1,1,1,1,1,1]) #  <--- this is a stubbed array for 50% wins for 10 trades
    the_total_profits_of_all_sequences << profits([-1,-1,-1,-1,-1,1,1,1,1,1]) #  <--- this is a stubbed array for 50% wins for 10 trades
    puts the_total_profits_of_all_sequences.inject(:+)
    # Rearrange the array, and take that array and give it to the 'profits' method to determine what the profits are.
    # Return the answer into an array. 
  end

  def menu
    intro
    get_user_data
    define_fixed_wins
    generate_all_trades
  end

private    # Everything below this shouldn't have to be altered

  def trade_array
    # This is only generated one time. It's the master array we will shuffle around.
    # This takes winning trades and places them in an array as a 1, and losing trades as a 0.
    all_trades = Array.new(@trades)
  
    win_spot = @lose_trades   # The win_spot is location in array where winning trade resides initially before shuffled around.
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

  def define_fixed_wins
    @win_trades = (@percentage.to_f / 100) * @trades
    @win_trades = @win_trades.to_i
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
    @win_fix_or_perc = gets.chomp.downcase
    puts "What amount more or less would it be? (-100 to infinite for percentage or any infinite for fixed)"
    @winner_change = gets.chomp.to_i
    puts "If you have a LOSING trade, would you like your next position size to be based on a percentage or a fixed amount more or less?"
    puts "(F)ixed or (P)ercentage or (S)tarting default amount"
    @lose_fix_or_perc = gets.chomp.downcase
    puts "If you picked F or P. What amount more or less would it be? (-100 to infinite for percentage or any infinite for fixed)"
    @loser_change = gets.chomp.to_i
  end



end

a = Forex.new
a
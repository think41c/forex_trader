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
    @trades = gets.chomp 
    puts "What percentage of trades will you win? 0-100 is allowed."
    @percentage = gets.chomp
    puts "We presume the exit is equadistant on both the winning and losing exit, therefore profit amounts are same loss amounts."
    puts "What's your initial win/loss dollar amount? 0-100 is allowed."
    @amount = gets.chomp
    puts "If you have a winning trade, would you like your next position size to be based on a percentage or a fixed amount more or less?"
    puts "(F)ixed or (P)ercentage"
    win_fix_or_perc = gets.chomp
    puts "What amount more or less would it be? (-100 to infinite for percentage or any infinite for fixed)"
    @winner_change = gets.chomp
    puts "If you have a LOSING trade, would you like your next position size to be based on a percentage or a fixed amount more or less?"
    puts "(F)ixed or (P)ercentage"
    @lose_fix_or_perc = gets.chomp
    puts "What amount more or less would it be? (-100 to infinite for percentage or any infinite for fixed)"
    @loser_change = gets.chomp
  end

  def define_fixed_wins
    # Here we need to take the percentage of wins and then reduce that to a fixed whole number based on the trades to test
    @win_trades = @percentage / 100 * @trades
    puts @win_trades
  end

  def generate_all_trades
    # Here we need to deal with every permutation possible of the percentage wins/losses he might have. 
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
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

  def generate_all_trades
    @lose_trades = @trades - @win_trades
    puts @lose_trades
    trade_array
    # Here we need to deal with every permutation possible of the percentage wins/losses he might have. 
  end

  def trade_array
    # This takes winning trades and places them in an array as a 1, and losing trades as a 0.
    all_trades = Array.new(@trades)
    puts all_trades
    p all_trades
    win_spot = @lose_trades
    lose_spot = 0
    @lose_trades.times do 
      all_trades[lose_spot] = 0
      puts "This is was losing trade"
      lose_spot += 1 
    end

    @win_trades.times do
      all_trades[win_spot] = 1
      puts "This was a winning trade"
      win_spot += 1
    end
    puts all_trades
  end


  def menu
    intro
    get_user_data
    define_fixed_wins
    generate_all_trades
    # puts @win_trades
    
  end
end

a = Forex.new
a
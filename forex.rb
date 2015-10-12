class Forex
  
  def initialize 
    puts "Welcome to Forex trader"
    menu
  end

  def menu
    puts "This program goes through every possible combination of trades for you."
    puts "You can enter your probability of a successful trade, say 50%, and the program will simulate"
    puts "each combination of X amount of trades that would still provide that probability. Such that in 10 trades you might have 5x"
    puts "winning streak, or never a streak more than 1 winning trade at a time. It will then show with all the potential combinations"
    puts "what the highest amount you could win, as well as the lowest amount you could lose. As the law of big numbers implies, long"
    puts "streaks are possible in any direction, which is the failure of martingale systems."
    puts "How many trades would you like to simulate? 0-20 is allowed."
    trades = get.chomp 
  end
end

a = Forex.new
a
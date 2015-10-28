# This revision of forex.rb doesn't necessitate all possible trades, but simply 10,000 trades using the probability given.
require './trade_creator.rb'

class Probability

  def initialize 
    @get_sequences = TradeCreator.new
    puts "Welcome to Forex trader"
    menu
  end

  def menu
  	puts "Probability trader takes 10,000 trades based on your percentage."
  	user_percent_win = get_user_data
  	all_trades = @get_sequences.trade_gen(user_percent_win)
  	puts "**** Here are the trades accessible ********"
  	p all_trades

  end

  def get_user_data
  	puts "What percentage of the time do you win?"
  	user_percent_win = gets.chomp.to_i
  	user_percent_win
  end

end

a = Probability.new
a
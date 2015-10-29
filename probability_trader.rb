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
  	all_trades = @get_sequences.trade_gen(get_user_data)
  	trade_sizes(all_trades)
  end

  def get_user_data
  	puts "What percentage of the time do you win?"
  	user_percent_win = gets.chomp.to_i
  end

  def starting_size # This can be user input later
  	100
  end

  def size_minimum(new_size)
  	new_size = starting_size if new_size < starting_size 
  	new_size
  end

  def trade_sizes(all_trades)
  	new_size = starting_size
  	all_trades.each_with_index do |trade, index| 
  		puts "heres the #{trade}"
  		if trade == 1 
  			new_size *= 0.5
  			puts "what's new size before trade minimum now #{new_size}"
  			new_size = size_minimum(new_size)
  			
  		else
  			new_size *= 1.5
  		end
  		puts "The new size is #{new_size.to_i}"
  	end
  end

end

a = Probability.new
a
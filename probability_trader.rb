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
  	new_size    = starting_size
  	trade_saver = []
  	all_trades.each_with_index do |trade, index| 
  		puts "Here's the #{trade}"
  		if trade == 1 
        trade_saver << profit_loss(new_size, trade)
  			new_size *= 0.5
  			new_size  = size_minimum(new_size)
  		else
        trade_saver << profit_loss(new_size, trade)
  			new_size *= 1.5
  		end
  		new_size = new_size.to_i
  		puts "The new size is #{new_size}"
  	end
  	puts trade_saver
  end

  def profit_loss(new_size, trade)
  	profit = new_size * trade
  	profit
  end


end

a = Probability.new
a
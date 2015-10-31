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
    display_trades
  end

  def display_trades
    puts "Would you like to see all trades? (Y)es, or (N)o?"
    display = gets.chomp.downcase
    if display == "y" 
      post
    else
      puts "You didn't enter \"Y\" Ending now"
    end
  end

  def get_user_data
  	puts "What percentage of the time do you win?"
  	user_percent_win = gets.chomp.to_i
  end

  def starting_size # This can be user input later
  	100
  end

  def maximum_size
    400
  end

  def size_minimum(new_size)
  	new_size = starting_size if new_size < starting_size 
  	new_size
  end

  def size_maximum(new_size)
    # new_size = maximum_size if new_size > maximum_size
    new_size = 100 if new_size > maximum_size
    new_size
  end

  def trade_sizes(all_trades)
  	new_size     = starting_size
  	@trade_saver = []
  	all_trades.each_with_index do |trade, index| 
  		if trade == 1 
        @trade_saver << profit_loss(new_size, trade)
        # new_size *= 3.0
  			new_size  += 100
        # new_size  = size_minimum(new_size)   # USE IF YOURE DECREASiNG FOR WINNERS
  			new_size  = size_maximum(new_size)   # USE IF YOURE increasing FOR WINNERS
  		else
        @trade_saver << profit_loss(new_size, trade)
        # new_size *= 2.00
  			new_size  -= 100
        # new_size  = size_maximum(new_size)  
        new_size  = size_minimum(new_size)
  		end
  		new_size = new_size.to_i
  	end
    puts @trade_saver.inject(:+)
  end

  def profit_loss(new_size, trade)
  	profit = new_size * trade
  	profit
  end

  def post
    puts @trade_saver
    initialize
  end

end

a = Probability.new
a
# a.post
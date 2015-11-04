# This revision of forex.rb doesn't necessitate all possible trades, but simply 10,000 trades using the probability given.
require './trade_creator.rb'
require './size_style.rb'

class Probability

  def initialize 
    @size_style    = SizeStyle.new
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
    500
  end

  def size_minimum(new_size)
  	new_size = starting_size if new_size < starting_size 
    new_size = maximum_size if new_size > maximum_size
  	new_size
  end

  def equity_percent_to_risk
    0.30
  end

  def trade_sizes(all_trades)
  	new_size        = starting_size.to_i
  	@trade_saver    = []
    ongoing_profits = []

  	all_trades.each_with_index do |trade, index| 
  	
     #################### THIS IS IF WE ONLY USE 10% OF OUR EQUITY TO TRADE	
        @trade_saver << profit_loss(new_size, trade)
        ongoing_profits << @trade_saver.inject(:+)
        puts "#{equity_percent_to_risk*100}% of your equity is #{(ongoing_profits[-1]* equity_percent_to_risk).to_i}"
        equity_based_size = ongoing_profits[-1] * equity_percent_to_risk
        if equity_based_size < starting_size
          new_size = starting_size
          # new_size = equity_based_size
        else 
          new_size = equity_based_size.to_i
        end
        puts "For trade #{index} the size is #{new_size}."
        # if 10% of the overall P&L is less than 100 then new size is 100
        # else new_size is now 10% of the overall P&L
      # end 
    ##############################################

    ##########################################################
    # This is for a percentage based on the prior winner or loser. 
    #   if trade == 1 
    #     @trade_saver << profit_loss(new_size, trade)
        
    #     new_size *= 0.75
  		# 	# new_size  = 100

    #     new_size  = size_minimum(new_size)
  		# else
    #     @trade_saver << profit_loss(new_size, trade)
        
    #     new_size *= 1.3
  		# 	# new_size  = 100
        
    #     new_size  = size_minimum(new_size)
  		# end

      puts "Trade #{index} begins w/ your current overall P&L of #{@trade_saver.inject(:+).to_i} \n\n"
      # ongoing_profits << @trade_saver.inject(:+)
      
  	end

    puts "Your final P&L is #{@trade_saver.inject(:+)}"
    puts "Your biggest loser was #{@trade_saver.min}"
    puts "Your biggest drawdown was #{ongoing_profits.min}"
    puts "The actual percentage of winners was #{@get_sequences.percentage.to_i}"
  end

  def profit_loss(new_size, trade) 
    # This method deals with whether a winner and loser are the same profits, or differing amounts of Profits.

    @size_style.equal_win_and_losers(new_size, trade)
    # OR
    # @size_style.diff_sized_win_and_losers(new_size, trade)
  end

  def post
    puts @trade_saver
    initialize
  end

end

a = Probability.new
a

# This revision of forex.rb doesn't necessitate all possible trades, but simply 10,000 trades using the probability given.
require './trade_creator.rb'
require './size_style.rb'
require './output_messages.rb'


class Probability

  def initialize 
    @size_style      = SizeStyle.new
    @get_sequences   = TradeCreator.new
    @output_messages = OutputMessages.new
    @equal_win_loss_flag = true
    @maximum_size        = true
    @size_minimum_flag   = true
    @arbitrary_starting_size_flag = true
    puts "Welcome to Forex trader"
    menu
  end

  def menu
    puts "Probability trader takes 10,000 trades based on your percentage."
    puts "The defaults are currently set as:"
    puts "Winners and losers the same size? #{@equal_win_loss_flag}"
    puts "Size minimum used? #{@size_minimum_flag}"
    puts "Arbitrary_starting_size? #{arbitrary_starting_size_flag}"
    puts "Size maximum used?"
    puts "Trading sizes based on account equity or the last trade?"
    puts "and so on..."

    all_trades = @get_sequences.trade_gen(get_user_data)
    trade_sizes(all_trades)
    display_trades
  end

  def display_trades
    puts "Would you like to see all trades? (Y)es, or (N)o?"
    display = gets.chomp.downcase
    if display == "y" 
      display_all_trades
    elsif display == "n"
      @output_messages.exit_screen
    else
      puts "You didn't enter \"Y\" Try again."
      display_trades
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
    if @maximum_size == true
      max_size = 10000
    else
      max_size = +1.0 / 0.0
    end
    max_size
  end

  def equity_percent_to_risk
    0.30
  end

  def size_minimum(new_size)
  	new_size = starting_size if new_size < starting_size 
    new_size = maximum_size  if new_size > maximum_size
  	new_size
  end

  def arbitrary_starting_size
    100
  end

  def new_size_based_on_equity(new_size, ongoing_profits, trade, index)
    puts "I'm in new_size_based_on_equity and new_size is :#{new_size}:"
    @trade_saver << profit_loss(new_size, trade)
    ongoing_profits << @trade_saver.inject(:+)
    puts "#{equity_percent_to_risk*100}% of your equity is #{(ongoing_profits[-1]* equity_percent_to_risk).to_i}"
    equity_based_size = ongoing_profits[-1] * equity_percent_to_risk
    if equity_based_size < starting_size
      new_size = starting_size
      # new_size = equity_based_size
      @prior_trade_size = new_size
    else 
      new_size = equity_based_size.to_i
      @prior_trade_size = new_size
    end
    puts "For trade #{index} the size is #{new_size}."
  end

  def new_size_based_on_prior_trade(new_size, ongoing_profits, trade, index)
    #This is for a percentage based on the prior winner or loser. 
    puts "#{new_size} is starting off as..."
    if trade == 1 
      @trade_saver << profit_loss(new_size, trade)    
      new_size *= 2
      @prior_trade_size = new_size
      if @arbitrary_starting_size_flag == true
        new_size  = arbitrary_starting_size      # Use if when you win, you go back to an arbitrary 'starting size'
      end
      # new_size  = size_maximum(new_size)  # Use if imposing a size_maximum
    else
      @trade_saver << profit_loss(new_size, trade)
      new_size *= 4
    # new_size  = 100                       # Use if when you lose, you go back to an arbitrary 'starting size'
      if size_minimum_flag == true
        new_size = size_minimum(new_size)
      end
      @prior_trade_size = new_size
    end
    ongoing_profits << @trade_saver.inject(:+)
  end


  def trade_sizes(all_trades)
  	new_size        = starting_size.to_i
  	@trade_saver    = []
    ongoing_profits = []

  	all_trades.each_with_index do |trade, index| 
      ### Comment out the method of new size methodology you don't want ######
        new_size_based_on_equity(new_size, ongoing_profits, trade, index)
      # new_size_based_on_prior_trade(new_size, ongoing_profits, trade, index)
      new_size = @prior_trade_size #  <---- ***This causing new_size to turn into nil.*** 
    
      puts "Trade #{index} begins w/ your current overall P&L of #{@trade_saver.inject(:+).to_i} \n\n"
  	end
    drawdown_result = drawdown(ongoing_profits)
    @output_messages.end_report(ongoing_profits, @trade_saver, drawdown_result, @get_sequences.percentage.to_i)
  end

  
  def drawdown(ongoing_profits)
    ongoing_profits = [10,20,0,100]   # **This is for testing purposes - remove when verified drawdown is 20**
    biggest_drawdown = 0 
    low  = 0 
    high = 0 
    ongoing_profits.each_with_index do |current_profit, index|
      puts "The following code should be doing things to calculate drawdown."
      if current_profit > biggest_drawdown  # For a winning trade to start, it will always go here first.
        high = current_profit               # The current profits will be the high of the ongoing equity.
      elsif current_profit < low               
        low  = current_profit
      else 
        low  = current_profit
      end
      biggest_drawdown = high - low
    end

    biggest_drawdown 
  end

  def profit_loss(new_size, trade) 
    # This method deals with whether a winner and loser are the same profits, or differing amounts of Profits.
    if @equal_win_loss_flag == true
      @size_style.equal_win_and_losers(new_size, trade)
    else
      @size_style.diff_sized_win_and_losers(new_size, trade)
    end
  end

  def display_all_trades
    puts @trade_saver
    initialize
  end


end

a = Probability.new
a

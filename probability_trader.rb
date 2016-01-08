# This revision of forex.rb doesn't necessitate all possible trades, but simply 10,000 trades using the probability given.
require './trade_creator.rb'
require './size_style.rb'
require './output_messages.rb'


class Probability

  def initialize 
    system("clear")
    @size_style      = SizeStyle.new
    @get_sequences   = TradeCreator.new
    @output_messages = OutputMessages.new
    @equal_win_loss_flag = true
    @maximum_size        = true
    @size_minimum_flag   = false
    @arbitrary_starting_size_flag = true
    @based_on_equity_flag         = false
    @output_messages.welcome
    menu
  end

  def menu
    puts "Probability trader takes 10,000 trades based on your percentage."
    puts "The defaults are currently set as:"
    puts "Winners and losers the same size? #{@equal_win_loss_flag}"
    puts "Size minimum used? #{@size_minimum_flag}"
    puts "Arbitrary_starting_size? #{@arbitrary_starting_size_flag}"
    puts "Size maximum used? #{@maximum_size}"
    puts "Trading sizes based on account equity? #{@based_on_equity_flag}"
    puts "Default starting size is #{starting_size}"
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

  def starting_size
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
      if @size_minimum_flag == true
        new_size = starting_size  
      else
        new_size = equity_based_size
      end
      @prior_trade_size = new_size
    else 
      new_size = equity_based_size.to_i
      @prior_trade_size = new_size
    end
    puts "For trade #{index} the size is #{new_size}."
  end

  def new_size_based_on_prior_trade(new_size, ongoing_profits, trade, index)
    #This is for a percentage based on the prior winner or loser. 

    puts "The size of the next trade will be the following: #{new_size}"
    if trade == 1 
      @trade_saver << profit_loss(new_size, trade)    
      new_size *= 2
      @prior_trade_size = new_size
      if @arbitrary_starting_size_flag == true
        new_size  = arbitrary_starting_size      # When you win, revert arbitrary 'starting size' (used in martingale strategies)
      end
      
      if @maximum_size == true
        new_size  = size_minimum(new_size)
      end

    else
      @trade_saver << profit_loss(new_size, trade)
      new_size *= 4

      if @arbitrary_starting_size_flag == true
        new_size  = arbitrary_starting_size      # When you win, revert arbitrary 'starting size' (used in martingale strategies)
      end

      if @size_minimum_flag == true
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

    if @based_on_equity_flag == true
      puts "New size is based on a percentage of your equity"
    else
      puts "New size is based on the prior trade, such as a (anti)-margingale system."  
    end

  	all_trades.each_with_index do |trade, index| 
      puts "Trade #{index}. Starting equity: #{@trade_saver.inject(:+).to_i} \n"
      puts "The trade was a winner." if trade > 0 
      puts "the trade was a loser."  if trade < 0

      if @based_on_equity_flag == true
        new_size_based_on_equity(new_size, ongoing_profits, trade, index)
      else 
        new_size_based_on_prior_trade(new_size, ongoing_profits, trade, index)
      end
      new_size = @prior_trade_size
  	end

    drawdown_result = drawdown(ongoing_profits)
    @output_messages.end_report(ongoing_profits, @trade_saver, drawdown_result, @get_sequences.percentage.to_i)
  end

  
  def drawdown(numbers)
    high         = 0
    drawdown = 0
    numbers.each do |x|
      high = x if x > high
      if x < high
        if high-x > drawdown
          drawdown = high-x
        end
      end
    end
    drawdown
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
    pnl_total = 0
    @trade_saver.each_with_index do |profit, index|
      pnl_total += profit
      puts "On trade #{index}, you made/lost: #{profit.to_i}. Your cumulative P&L is #{pnl_total.to_i}"
      if profit.to_i > 0 
        puts "It was a profitable trade."
      end
      
    end

    puts "Hit Enter to continue"
    gets.chomp.downcase
    initialize
  end
end

a = Probability.new
a

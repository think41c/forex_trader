class OutputMessages

  def end_report(ongoing_profits, trade_saver, drawdown_result, percentage)
    puts <<-STR
      Your final P&L is #{trade_saver.inject(:+)} 
      Your biggest loser was #{trade_saver.min} 
      Your lowest account balance was #{ongoing_profits.min} 
      Your biggest drawdown was #{drawdown_result} 
      The actual percentage of winners was #{percentage}"
    STR
  end

  def welcome
    puts "Welcome to Forex trader"
  end

  def exit_screen
    puts "Thanks for trying out your trading ideas with Probabilty Trader. Exiting to prompt!"
  end
end

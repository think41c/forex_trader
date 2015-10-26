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
  	@get_sequences.trade_gen(50)
  end

end

a = Probability.new
a
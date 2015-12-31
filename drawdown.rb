class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		high     = 0
		low      = @numbers[0]
		drawdown = []
    new_high = false

		@numbers.each do |x|
			if x > high
			  high = x
        new_high = true  # every number after this that isn't a) a new high and b) lower than this number should
                         # be subtracted out for drawdown.
        drawdown << 0    # Put in a 0 into the drawdown. We're looking for the highest number in the drawdown array. 
      end
      
      if x < high  
        low = x
        drawdown << high-low    # Probably doesn't need to be an array, but can computed w/ an if statement.
      end

      puts "The drawdown is #{drawdown.max}"  
		end

	end
end

a = Drawdown.new([1,4,0,5,0,2,3,6,0,500,400,900,100,700,0,0,1000,900,11000,10000])
a.calculate

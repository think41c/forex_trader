class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		high     = 0
		low      = @numbers[0]
		drawdown = []
    new_high = false

		puts "The numbers to loko at are #{@numbers}"
		@numbers.each do |x|
			puts "looking at #{x}"
			if x > high
			  high = x
        new_high = true  # every number after this that isn't a) a new high and b) lower than this number should
                         # be subtracted out for drawdown.
        drawdown << 0    # Put in a 0 into the drawdown. We're looking for the highest number in the drawdown array. 
      end
      
      if x < high  
        low = x
        puts "The drawdown could be #{high - low}"
        drawdown << high-low
      end

      puts "Current low is #{low} and the high is #{high}"
      puts "Drawdown is #{high-low}"
      p drawdown
      puts "The drawdown is #{drawdown.max}"
		end

	end
end

a = Drawdown.new([1,4,0,5,0,2,3,6,0])
a.calculate

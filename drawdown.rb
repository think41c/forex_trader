class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		high     = 0
		low      = @numbers[0]
		drawdown = 0
    new_high = false

		puts "The numbers to loko at are #{@numbers}"
		@numbers.each do |x|
			puts "looking at #{x}"
			if x > high
			  high = x
        new_high = true  # every number after this that isn't a) a new high and b) lower than this number should
                         # be subtracted out for drawdown.
      end
      
      if x < high  
        low = x
      end

      puts "Current low is #{low} and the high is #{high}"
      puts "Drawdown is #{high-low}"

		end

	end
end

a = Drawdown.new([1,4,0])
a.calculate
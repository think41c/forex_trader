class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		high     = 0
		drawdown = []

		@numbers.each do |x|
			high = x if x > high
      
      if x < high  
        drawdown << high-x    # Probably doesn't need to be an array, but can computed w/ an if statement.
      end

      puts "The drawdown is #{drawdown.max}"  
		end

	end
end

a = Drawdown.new([1,4,0,5,0,2,3,6,0,500,400,900,100,700,0,0,1000,900,11000,10000])
a.calculate

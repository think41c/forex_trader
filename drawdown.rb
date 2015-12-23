class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		high     = 0
		low      = @numbers[0]
		drawdown = 0

		puts "The numbers to loko at are #{@numbers}"
		@numbers.each do |x|
			puts "looking at #{x}"
			if x > high
			  high = x
      end
      
      if x < high  
        low = x
      end
      puts "Current low is #{low} and the high is #{high}"
       

		end

	end
end

a = Drawdown.new([1,3,2])
a.calculate

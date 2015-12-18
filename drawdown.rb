class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		high     = 0
		low      = 0
		drawdown = 0

		puts "The numbers to loko at are #{@numbers}"
		@numbers.each do |x|
			puts "looking at #{x}"
		end

	end
end

a = Drawdown.new([1,2,3])
a.calculate

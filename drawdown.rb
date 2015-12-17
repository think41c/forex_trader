class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		puts "The numbers to loko at are #{@numbers}"
	end
end

a = Drawdown.new([1,2,3])
a.calculate

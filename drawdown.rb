class Drawdown
	def initialize(numbers)
		@numbers = numbers
	end

	def calculate
		high     = 0
    biggest_draw = 0

		@numbers.each do |x|
			high = x if x > high
      if x < high
        if high-x > biggest_draw
          biggest_draw = high-x
        end
      end
		end
    puts biggest_draw
	end
end

a = Drawdown.new([1,4,0,5,0,2,3,6,0,500,400,900,100,700,0,0,1000,900,11000,10000])
a.calculate

class Drawdown
	def calculate(numbers)
		high         = 0
    drawdown = 0
		numbers.each do |x|
			high = x if x > high
      if x < high
        if high-x > drawdown
          drawdown = high-x
        end
      end
		end
    drawdown
	end
end

a = Drawdown.new
puts a.calculate([1,4,0,5,0,2,3,6,0,500,400,900,100,700,0,0,1000,900,11000,10000])


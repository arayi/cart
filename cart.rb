
# Parses a file containing "shopping carts" separated by blank lines.

# Each line of the shopping cart is in the format:
# (int) (name of item) at (dollars)

# Tax is calculated based on whether the item is imported & whether it is in a tax-exempt category.

# Output file contains the cost with tax per item, the total tax for the cart, and the total price for the cart.


# Opens input file and loads lines into an array, changing every "input" to "output"
input = []
File.open("input.txt", "r") do |contents|
  contents.each_line do |x|
    input << x.sub("Input", "Output").sub("INPUT", "OUTPUT")
  end
end

output = File.open("output.txt", "w")

while input.any? do # If there is still input to process,
	line = input.shift # Remove the first line from the array
	current_cart = []

	# Keeps all non-cart lines intact
	output.puts line if line =~ /^O/
	output.puts "\n" if line.length == 2

	# Identifies the bounds of a cart and loads it into an array
	while line =~ (/^\d/)
		current_cart << line
		line = input.shift
	end

	# Checks if there is currently a cart, and if so, processes its tax/total
	if current_cart.any?
		cart_tax = 0
		cart_total = 0

		current_cart.each do |item|
			# Initializes total, gets quantity/price from line
			item_total = 0
			quantity = item.match(/^\d+/)[0].to_f
			price = item.match(/[\d.]+$/)[0].to_f.round(2)

			# Figures out the tax for the item based on its tax categories
			tax_rate = 0.10 # Base tax rate of 10%
			tax_rate += 0.05 if item =~ /imported/
			tax_rate -= 0.10 if (item =~ /book/ || item =~ /chocolate/ || item =~ /pills/)
			tax_rate = tax_rate.round(2) # Math errors occur w/o round. In fact, you can pretty much assume that all the way down.

			tax = (((quantity * price * tax_rate) * 20).ceil.to_f / 20).round(2) # Calculates tax per item

			# Determines item total and displays it to two decimal points
			item_total = (price + tax)
			output.puts item.sub(/[\d.]+$/, "#{sprintf("%.2f", item_total)}")

			# Adds this item's tax/total to the cart's tax/total
			cart_tax += tax
			cart_total += item_total

		end

		# Displays tax and total to two decimal points
		output.puts "Sales Tax: #{sprintf("%.2f", cart_tax)}"
		output.puts "Total: #{sprintf("%.2f", cart_total)}\n\n"
	end
end

puts "Check output.txt for the results!"
require 'json'
require 'artii'

# Get path to products.json, read the file into a string,
# # and transform the string into a usable hash
def set_up
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
$products_hash = JSON.parse(file)
$report_file = File.new("report.txt", "w+")
end

set_up

# Print "Sales Report" in ascii art
a = Artii::Base.new :font => 'slant'
puts a.asciify('Sales Report')


# Print today's date
def today_date
    date = Time.new
    date.strftime("%Y-%m-%d")
end
puts today_date
# Print "Products" in ascii art

puts a.asciify('Products')

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price
def item_array(item, options = {})
    item_a = []
    purchases_a =[]
    if options[:hashed]
        $products_hash["items"].each do |toy|
            option_sub = options[:hashed]
        purchases_a = purchases_a.push toy[option_sub.to_s]
		purchases_a
        end
        purchases_a.each do |some|
            item_a = item_a.push some[item]
        end
		return item_a
    else
        $products_hash["items"].each do |toy|
        item_a = item_a.push toy[item]
        end
    end
    return item_a
end

title = item_array "title"
price = item_array "full-price"

puts title + price

prices = item_array("price", hashed: "purchases")
puts prices 

# Print "Brands" in ascii art

puts a.asciify('Brands')

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined

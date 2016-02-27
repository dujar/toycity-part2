require 'json'
require 'artii'

def start
	set_up# load, read, parse, and create the files
	create_report# create the report
end


# Get path to products.json, read the file into a string,
# # and transform the string into a usable hash
def set_up
path = File.join(File.dirname(__FILE__), '../data/products.json')
file = File.read(path)
$products_hash = JSON.parse(file)
$report_file = File.new("report.txt", "w+")
end
set_up
#start#call start method to trigger report generation

# Print "Sales Report" in ascii art
a = Artii::Base.new :font => 'slant'
puts a.asciify('Sales Report')


# Print today's date
def what_date today
    if today=="today"
        date = Time.new
        date.strftime("%Y-%m-%d")
    else
        puts "write todayin order to get today's date"
    end
end
puts what_date "today"
# Print "Products" in ascii art

puts a.asciify('Products')

# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (zo% or $) based off the average sales price

#methods gathering information for toy
# Print the name of the toy
	# Calculate and print the total number of purchases
	# Print the retail price of the toy
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (% or $) based off the average sales price

# Print "Brands" in ascii art

puts a.asciify('Brands')

#methods gathering information for Brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined



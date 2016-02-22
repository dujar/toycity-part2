require 'json'
require 'artii'

#def start
#	set_up# load, read, parse, and create the files
#	create_report# create the report
#end


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
	# Calculate and print the average discount (zo% or $) based off the average sales price
#

    #fetching an item in an array or hash
def item_array(item)

    item_a = []
        $products_hash["items"].each do |toy|
            if toy[item]=="purchases"
                item_a = item_a.push toy[item].to_a
            else
                 item_a = item_a.push toy[item]
            end
        end
    return item_a
end

def item_array_p(item)
purchases = item_array "purchases"
    item_a = []
       purchases.each do |toy|
        item_a = item_a.push toy[item]
       end
    return item_a
end


#convert string to float from hash

def string_to_float hash
    hash.map do |i|
        i.to_f
    end
end

def print_result array, options ={}
        if options[:toy]
        array.each do |item|
        puts " toy name: #{item}"
        end
    end
end

def item_any_array hash, item
    some = []
    hash.each do |i|
        some = some.push i[item]
    end
    return some
end

def sum_all array
    array.inject(:+).round(2)
endzo

def average_price array
    summed = sum_all array
    average = summed/array.length
    average.round(2)
end

def discount 
    full_price =item_array "full-price"
    full_price_f = full_price.map{|i| i.to_f}
    purchases = item_array "purchases"
    purchases_price = item_any_array purchases.flatten, "price"
    some = []
    full_price_f.each do  |i|
        h= 0
        hh = 1
        sold = purchases_price[h..hh]
        price = sum_all sold
        discounted = full_price_f[h]-price
        some = some.push discounted.round(2)
        h = h + 2
        hh= hh + 2
    end
    return some

end



toys = item_array "title"
retail_price = item_array "full-price"
retail_price = string_to_float retail_price
purchases = item_array "purchases"

# Print the name of the toy
puts"the names of the toys are :"
puts item_array "title"
puts" the retail prices are #{retail_price}"
	# Calculate and print the total number of purchases
puts "total number of purchases"
	# Print the retail price of the toy

	# Calculate and print the total amount of sales
purchases_price =item_any_array purchases.flatten, "price"
purchases_sum = purchases_price.count
puts purchases_sum
puts " the sum of sales is : #{sum_all purchases_price} respectively"



	# Calculate and print the average price the toy sold for
puts "the average price of each toy is"
puts average_price purchases_price[0..1]
puts average_price purchases_price[2..3]
puts average_price purchases_price[4..5]

puts retail_price
	# Calculate and print the average discount (% or $) based off the average sales price

puts "the average discount of each toy is:"



#puts item_array_p "price"







# Print "Brands" in ascii art

puts a.asciify('Brands')

# For each brand in the data set:
	# Print the name of the brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined

    brands = item_array "brand"
    brands = brands.uniq
    puts "hi #{brands}"
    def branding itemic, options = {}
        lego_stock = []

        branded = options[:brand] || "Nano Blocks"

        $products_hash["items"].each do |item|
            what = item["brand"]
            if branded==item["brand"]
                lego_stock = lego_stock.push item[itemic]
            else
            end
        end
        lego_stock
    end

    hi =  branding "full-price", {brand: "LEGO"}
    puts hi.empty?
    puts hi.inspect
    puts hi

        


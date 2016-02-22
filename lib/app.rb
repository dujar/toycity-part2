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

#methods gathering information for toy
    def item_array(options = {})
                if options[:purchases]=="yes" && options[:count]=="yes"
                    
                    purch = []
                    $products_hash["items"].each do |purcha|
                    purch = purch.push purcha["purchases"].count
                    end
                    arr = purch
                    return arr



                elsif options[:purchases]=="yes" && options[:sum]=="yes"
                     
                    purch1 = []
                    purch = []
                    $products_hash["items"].each do |purcha|
                        purch = purch.push purcha["purchases"]
                        purch1 = purch1.push purcha["purchases"].count
                    end

                    arr =[]
                    arr1 = []
                    arr2 = []
                    purch1.each_index do |index|
                        purch[index].each do |toy|
                        arr = arr.push toy[options[:item]]
                        end
                    arr1 = arr.inject(:+)
                    arr2 = arr2.push arr1
                    arr=[]
                    end
                    return arr2

                elsif options[:purchases]=="yes" && options[:average]=="yes"
                     
                    purch1 = []
                    purch = []
                    $products_hash["items"].each do |purcha|
                        purch = purch.push purcha["purchases"]
                        purch1 = purch1.push purcha["purchases"].count
                    end

                    arr =[]
                    arr1 = []
                    arr2 = []
                    purch1.each_index do |index|
                        purch[index].each do |toy|
                        arr = arr.push toy[options[:item]]
                        end
                    arr1 = arr.inject(:+)
                    arr2 = arr2.push arr1/arr.length
                    arr = []
                    end
                    return arr2

                elsif options[:purchases]=="yes" && options[:discount]

                    averaged = item_array item: "price", purchases: "yes", average: "yes"
                    full_price = item_array item: "full-price"
                    discounted = []
                    full_price.each_index do |i|
                        discounted = discounted.push (full_price[i].to_f-averaged[i]).round(2)
                    end
                    
                    return discounted
                        



                elsif options[:purchases] && options[:item]
                    purch = []
                    $products_hash["items"].each do |purcha|
                        purch = purch.push purcha["purchases"]
                    end
                    arr =[]
                    purch.each do |toy|
                        arr = arr.push toy[options[:item]]
                    end

                    return arr
                
                
                else
                    arr =[]
                    $products_hash["items"].each do |toy|
                        arr = arr.push toy[options[:item]]
                    end
                    return arr
                end
    end
# Print the name of the toy
puts "the name of the toys are:"
puts item_array item: "title"
	# Calculate and print the total number of purchases
puts "the number of purchases of each toy are:"
puts item_array item: "", count: "yes", purchases: "yes"
	# Print the retail price of the toy
puts "the retail price of each toy are"
puts item_array item: "full-price"
	# Calculate and print the total amount of sales
puts "the total amount of sales for each toy are:"
puts item_array item: "price", purchases: "yes", sum: "yes"
	# Calculate and print the average price the toy sold for
puts "the average price the toy sold for are:"
puts item_array item: "price", purchases: "yes", average: "yes"
	# Calculate and print the average discount (% or $) based off the average sales price
puts "the average discount in $ are:"
puts item_array item: "price", purchases: "yes", discount: "yes"

# Print "Brands" in ascii art

puts a.asciify('Brands')

#methods gathering information for Brand
    def brand_array(options = {})
                    lego = []
                    nano =[]
                    $products_hash["items"].each do |brand|
                        
                        if brand["brand"]== "LEGO"
                            lego = lego.push brand[options[:item]].to_f
                        else
                            nano = nano.push brand[options[:item]].to_f
                        end
                    end

                if options[:item] && options[:stock]=="yes"
                    
                    lego_sum = lego.inject(:+)
                    nano_sum = nano.inject(:+)
                    brand_sum = [LegoStock: lego_sum, NanoStock: nano_sum]
                    return brand_sum
                elsif options[:average]=="yes" && options[:item]

                    lego_sum = lego.inject(:+)
                    nano_sum = nano.inject(:+)
                    lego_price = lego_sum/lego.length
                    nano_price = nano_sum/nano.length
                    brand_sum = [LegoMeanPrice: lego_price.round(2), NanoMeanPrice: nano_price.round(2)]
                    return brand_sum
                else
                   puts "are you sure you did not forget any options?"
                    
                end
    end
# For each brand in the data set:
	# Print the name of the brand
    puts "the different brands are:"
    puts (item_array item: "brand").uniq
	# Count and print the number of the brand's toys we stock
    puts "the amount of stocks each brand has are:"
    puts brand_array item: "stock", stock: "yes"
	# Calculate and print the average price of the brand's toys
    puts "the average price of the brand's toys are:"
    puts brand_array item: "full-price", average: "yes"
	# Calculate and print the total sales volume of all the brand's toys combined
    puts "the sum of all the toys combined are:"
    puts (item_array item: "price", purchases: "yes", sum: "yes").inject(:+).round(2)



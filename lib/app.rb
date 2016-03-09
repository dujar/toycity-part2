require 'json'
require 'artii'
require 'pp'

# Get path to products.json, read the file into a string,
#and transform the string into a usable hash

  def set_up
    path = File.join(File.dirname(__FILE__), '../data/products.json')
    file = File.read(path)
    products_hash = JSON.parse(file)
    $products = products_hash["items"]
    $report_file= File.new("report.txt", "w+")
  end

  def create_report

   what_date("today")
   artii_art("Sales Report")
   artii_art("Products")
   print_report_toys
   artii_art("Brands")
   print_report_brands
   total_sales_outstanding
  end

  def start
	  set_up# load, read, parse, and create the files
    create_report
    $report_file.close
  end


# Print today's date
  def what_date today
    if today=="today"
        date = Time.new
     $report_file.puts   date.strftime("%Y-%m-%d")
    else
      $report_file.puts "write todayin order to get today's date"
    end
  end
#print ascii text from artii ruby gem
  def artii_art what
    a = Artii::Base.new :font => 'slant'
    $report_file.puts a.asciify(what)
  end

#Code for Products
# For each product in the data set:
	# Print the name of the toy
	# Print the retail price of the toy
	# Calculate and print the total number of purchases
	# Calculate and print the total amount of sales
	# Calculate and print the average price the toy sold for
	# Calculate and print the average discount (zo% or $) based off the average sales price
  def arrays_take item
    $products.select{|product| product[item]}
  end

  def toys numb
     $products[numb]
  end
  
  def purchases toy
      purch = []
    toy.select do |item|
        purch << item["price"]
    end
    return purch
  end

  def total_purchases toy
    purch = purchases toy
    return purch.inject(:+)
  end

  def average_purchase toy
      purch = total_purchases toy
      return purch/purchases(toy).count
  end

  def discount toy
    purch = toy["purchases"]
    toy["full-price"].to_f-total_purchases(purch)/purchases(purch).count
  end

  def print_report_toys
    (0..2).each do |i|
    toy = toys i
    $report_file.puts "***********************************************"
    $report_file.puts "Toy's title: #{toy["title"]}"
    $report_file.puts "***********************************************"
    $report_file.puts "Toy's price: $#{toy["full-price"]}"
    $report_file.puts "Toy's number of purchases : #{toy["purchases"].count}"
    $report_file.puts "Toy's total sales: $#{total_purchases(toy["purchases"])}"
    $report_file.puts "Toy's average price: $#{average_purchase toy["purchases"]}"
    $report_file.puts "Toy's average discount: $#{discount toy}"
    end
  end

##code for Brand

#methods gathering information for Brand
	# Count and print the number of the brand's toys we stock
	# Calculate and print the average price of the brand's toys
	# Calculate and print the total sales volume of all the brand's toys combined

  # creates the respective brand arrays and provide the number of brands available 
  def brand_numb
    productscount = $products.count
    brands =[]
    (0..productscount-1).each do |i|
    brands << $products[i]["brand"]
    end
    brands = brands.uniq
    num = brands.count
    (0..num-1).each do |i|
    send(:define_method, "brand#{i}") do
     $products.select{|item|  item if item["brand"]== brands[i]}
      end
    end
    return num
  end

  def print_report_brands
    (0..brand_numb-1).each do |i|
    brand = eval("brand#{i}")
      $report_file.puts "***********************************************"
      $report_file.puts "Brand name: #{brand[0]["brand"]}"
      $report_file.puts "***********************************************"
      $report_file.puts "Stock available: #{stock_available brand}"
      $report_file.puts "Brand's average retail price : $#{brand_average_price brand}"
      $report_file.puts "Brand's total sales: $#{total_brand_purchases(brand)}"
     # $report_file.puts "Toy's average discount: #{discount toy}"
      end
  end

  def total_brand_purchases brand
    purchases = brand.map{|purch| purch["purchases"]}
    prices = purchases.flatten.map{|item| item["price"]}
    sum_price =prices.inject(:+)
    return sum_price.round(2)
  end

  def stock_available brand
    stocks = brand.map{|item| item["stock"]}
    return stocks.inject(:+)
  end

  def brand_average_price brand
    prices = brand.map{|item| item["full-price"].to_f}
    return (prices.inject(:+)/prices.count).round(2)
  end


  def total_sales_outstanding
      $report_file.puts "***********************************************"
      $report_file.puts " The total sales of all the brands combined are : $#{total_brand_purchases $products}"
  end

  start


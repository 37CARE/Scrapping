require 'rubygems'
require 'nokogiri'
require 'open-uri'

def currency

loop{
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
  
  currencies_values = {}
  scrapped = page.css('a[class = "price"]')
 
  scrapped.each do |data|
  	currency = data["href"].sub!("/currencies/","").sub!("/#markets","")
  	value = data["data-usd"]    
    currencies_values[currency] = value  
  end

  puts currencies_values
  sleep(3600)
}
end

currency

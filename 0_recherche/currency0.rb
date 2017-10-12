require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'


def currency

loop{
  page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
  
  values = []
  scrapped = page.css('a[class = "price"]')
  scrapped.each do |value|
  	values << value["data-usd"]
  end
  
  currencies = []
  scrapped.each do |currency|
    currencies << currency["href"].sub!("/currencies/","").sub!("/#markets","")
  end

  currencies_values = {}
  i = 0
  currencies.each do |key|
	currencies_values["#{key}"]= values[i]
	i += 1
	end


puts currencies_values
sleep(3600)
}
end


currency

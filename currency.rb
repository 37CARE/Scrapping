require 'rubygems'
require 'nokogiri'
require 'open-uri'


class CurrencyTable
attr_accessor :page

  def initialize

    @page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/"))   
    
  end

  def scrap
      
      currencies_values = {}
      scrapped = @page.css('a[class = "price"]')
     
      scrapped.each do |data|
        currency = data["href"].sub!("/currencies/","").sub!("/#markets","")
        value = data["data-usd"]    
        currencies_values[currency] = value  
      end
      
      puts currencies_values

  end

  def perform
    loop do 
        scrap
      sleep(3600)
    end
  end
end

digital_currency = CurrencyTable.new
digital_currency.perform
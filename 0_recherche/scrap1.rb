require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'



require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'


def open_link

  scrapped = []

  landing_page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))   

  links = []
  landing_page.css('a[class = lientxt]').each do |link|
	link_end = link["href"].sub!(".","http://annuaire-des-mairies.com")
	links << link_end

  end

links.each do |ville|
  page = Nokogiri::HTML(open("#{ville}"))   

  text_array = page.css('td[class = style27]').text.split
  error = []
  
  text_array.each do |element|
    if element.include?("@")
    	error << element
    	scrapped << element   
    end
  end

    if error.size == 0
    	scrapped << "UNAVAILABLE"
    end 
end 
  puts scrapped
  puts scrapped.size
  puts links.size

end

open_link
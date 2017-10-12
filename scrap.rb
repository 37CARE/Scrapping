require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def open_link

  annuaire_95 = {}
  scrapped = []
  villes = []
  links = []
  landing_page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))   

  landing_page.css('a[class = lientxt]').each do |ville|
    ville_name = ville["href"].sub!("./95/","").sub!(".html","").capitalize
    villes << ville_name
  end

  landing_page.css('a[class = lientxt]').each do |link|
	  full_link = link["href"].sub!(".","http://annuaire-des-mairies.com")
	  links << full_link
  end

  links.each do |url|
    page = Nokogiri::HTML(open("#{url}"))   
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

i = 0
villes.each do |key|
  annuaire_95["#{key}"]= scrapped[i]
  i += 1
  end

end 

  puts annuaire_95

end

open_link
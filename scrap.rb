require 'rubygems'
require 'nokogiri'   
require 'open-uri'


page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/"))   
puts page.class   # => Nokogiri::HTML::Document

link_array = []
page.css("a[href]").each do |link|
	link_array << link.to_s
end

mail_array = []
link_array.each do |mail|
	mail_array << mail if mail.include?("mailto") && mail.include?("@")
end

puts mail_array


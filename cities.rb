require 'rubygems'
require 'nokogiri'
require 'open-uri'


class CityMailScrapping
  
  def scrap_villes

    # DEFINITION DES ARRAYS ET DU HASH
    @annuaire_95 = {}
    @links = []
    @villes = []
    @mails =[]

    # OUVERTURE DE LA PAGE AVEC NOKOGIRI
      landing_page = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))   
    
    # DEFINITION DU TABLEAU DES VILLES ET DU TABLEAU DES URL 
      landing_page.css('a[class = lientxt]').each do |link|
        ville = link["href"].sub!("./95/","").sub!(".html","").capitalize
        @villes << ville
        full_url = link["href"].sub!(".","http://annuaire-des-mairies.com")
        @links << full_url
        end
  end

  def scrap_mails

    # OUVERTURE PROGRESSIVE DE CHAQUE URL ET DEFINITION DU TABLEAU DE MAILS
    @links.each do |url|
      sleep(rand(0.8..2.8))
      page = Nokogiri::HTML(open("#{url}"))   
      mail_element =  page.css('p:contains("@")')
      mail = mail_element.text
      mail = "Unavailable"  if mail.empty?
      puts mail
      @mails << mail
    end

  end

  def annuaire

    # ECRITURE DU HASH ANNUAIRE
    i = 0
    @villes.each do |key|
      @annuaire_95["#{key}"]= @mails[i]
      i += 1
    end
    print @annuaire_95

  end

  def perform

    scrap_villes
    scrap_mails
    annuaire

  end

end


mail_villes_95 = CityMailScrapping.new
mail_villes_95.perform
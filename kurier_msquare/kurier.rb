require 'rubygems'
require 'open-uri'
require 'nokogiri'

twitter_url = 'http://twitter.com/weser_kurier'

class Article
	def self.getByUrl(url)
		Article.new(parseHTML(url))
	end

	attr_accessor :page

	def initialize(page)
		@page = page
	end

	def hasImage
		@page.css('.labeled-image img').size > 0
	end

	def getImageHTML
		@page.css('.labeled-image img').first.content
	end
end

def parseHTML(url)
        Nokogiri::HTML(open(url, 'r'))
end

puts "Hi."
puts "Wir bauen Ihre Zeitung. Genau jetzt. Genau für Sie."
puts "Heute unter Anderem:"

headliner = nil
articles = []

parseHTML(twitter_url).css('.entry-content').each do |link|
	title = link.xpath('text()').first.content.strip
	if(title.match(/(\.|!|\?)$/))
		puts " - " + title
	end

	article = Article.getByUrl(link.css('a').last.content)
	if(headliner == nil)
		headliner = article
	else
		articles << article
	end
end

articles.each do |article|
	puts article.getImageHTML
end


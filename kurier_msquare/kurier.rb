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

	def size
		(getTeaser + getText.join).size
	end

	def getTitle
		@page.css('.top-content h1').first.content
	end

	def getTeaser
		@page.css('.top-content .bold').first != nil ? @page.css('.top-content .bold').first.content : ""
	end

	def getText
		@page.css('#content p').map { |text| text.content }
	end

	def hasImage
		@page.css('.labeled-image img').size > 0
	end

	def getImageURL
		@page.css('.labeled-image img').first.get_attribute('src')
	end

	def getImageCopyright
		@page.css('.labeled-image .copyright').first.content
	end
end

def makeKurier(articles)
	content = articles.map { |article| makeArticle(article) }.join
	output = readFile("template.html").gsub("%content%", content)
	File.open("index.html", 'w') { |f| f.write(output) }
end

def makeArticle(article)
	output = "<span>" + article.getTitle + "</span> "
	output += "<b>" + article.getTeaser + "</b>"
	output += article.getText.map { |text| "<p>" + text + "</p>" }.join
	
	return "<li>" + output + "</li>"
end

def readFile(file)
	output = ""
	open(file, 'r') do |infile|
		while(line = infile.gets)
			output += line + "\n"
		end
	end
	return output
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

articles.sort { |a, b| b.size <=> a.size }

makeKurier(articles)

puts "Schon fertig :-)"
puts "Ihre Zeitung liegt in der index.html."


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

def makeKurier(headliner, articles)
  content = makeArticle(headliner, true)
  content += articles.map { |article| makeArticle(article) }.join
  output = readFile("template.html").gsub("%content%", content)
  File.open("index.html", 'w') { |f| f.write(output) }
end

def makeArticle(article, header = false)
  output = ""
  if(article.hasImage)
    output += "<img src=\"" + article.getImageURL + "\" alt=\"\" title=\"" + article.getImageCopyright + "\" />"
  end
  output += "<span>" + article.getTitle + "</span>\n "
  output += "<b>" + article.getTeaser + "</b>\n "
  output += article.getText.map { |text| "<p>" + text + "</p>\n" }.join
  css_class = article.size > 2000 ? "big_article" : "small_article"
  css_class = header ? "headliner" : css_class
  "<li class=\"" + css_class + "\">" + output + "</li>\n\n"
end

def readFile(file)
  output = ""
  open(file, 'r') do |infile|
    while(line = infile.gets)
      output += line + "\n"
    end
  end
  output
end

def parseHTML(url)
  doc = Nokogiri::HTML(open(url, 'r'), nil, 'utf-8')
  return doc
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

  if(!link.css('a').last.nil?)
    article = Article.getByUrl(link.css('a').last.content)
    if(!(article.getTitle+article.getTeaser+article.getText.join).match(/Werder/))
      if(headliner.nil?)
         headliner = article
      else
         articles << article
      end
    end
  end
end

articles = articles.sort { |a, b| b.size <=> a.size }

makeKurier(headliner, articles)

puts "Schon fertig :-)"
puts "Ihre Zeitung liegt in der index.html."


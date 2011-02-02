require 'rubygems'
require 'mechanize'
require 'logger'

agent = Mechanize.new { |a| a.log = Logger.new("mech.log") }

articles = []

twitter_page = agent.get("http://twitter.com/weser_kurier")
twitter_page.links.each do |link|
	if(link.text.match(/tinyurl/))
		articles << link.click
	end
end

articles.each{ |article| puts article.title}

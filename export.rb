require 'pandoc-ruby'
require 'date'
require 'nokogiri'
require './post.rb'

# wordpress.xml is your exported wordpress XML file
f   = File.open('wordpress.xml')
doc = Nokogiri::XML(f)
f.close

doc.remove_namespaces!

items = doc.css('item')

items.each do |i|
  post_tags = i.css('category[nicename]').map(&:text)
  WordpressParser.parse_post(i, post_tags) unless post_tags.include?('Twitters')
end

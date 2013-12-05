require 'pandoc-ruby'

f = File.open('wordpress.xml')
doc = Nokogiri::XML(f)
f.close

items = doc.css('item')

puts items.length

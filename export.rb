require 'pandoc-ruby'
require 'date'
require 'nokogiri'
require './post.rb'

# wordpress.xml is your exported wordpress XML file
f = File.open('wordpress.xml')
doc = Nokogiri::XML(f)
f.close

doc.remove_namespaces!

items = doc.css('item')

posts = Array.new()

items.each do |i|
	post = Post.new(i.css('post_id').text, i.css('title').text)
	post.tags = i.css('category[nicename]').map(&:text)
	post.date = DateTime.parse(i.css('pubDate').text)
	post.link = i.css('link').text
	post.content = i.css('encoded').text

    comments = i.css('comment')
    if (comments.count>0)
        post.comments = Array.new()
        comments.each do |c|
            comment = Comment.new()
            comment.author_name = c.css('comment_author').text
            comment.date = c.css('comment_date').text
            comment.content = c.css('comment_content').text
            post.comments << comment
        end
    end

	posts << post
end

posts.reject { |p| p.tags.include?('Twitters') || p.comment_count == 0 }.each do |p|
	puts "#{p.id} - #{p.title}"
    converter = PandocRuby.new(p.content, :from => :html, :to  => :markdown)
    p.markdown_content = converter.convert
    puts p.markdown_content
end


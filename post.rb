require 'pandoc-ruby'
require 'nokogiri'
require 'date'

module WordpressParser

  POST_TEMPLATE = <<EOS
---
title: "%TITLE%"
post_date: %POST_DATE%
slug: %SLUG%
tags:
%TAGS%
---

EOS

  def build_file_name(post_name, post_date)
    return post_date.strftime("%Y-%m-%d-#{post_name}")
  end

  def parse_post(post_xml, post_tags)
    post_front_matter = String.new(POST_TEMPLATE)

    post_front_matter['%TITLE%'] = post_xml.css('title').text.gsub(/\"/, '\"')
    post_date = DateTime.parse(post_xml.css('pubDate').text)
    post_front_matter['%POST_DATE%'] = post_date.strftime('%Y-%m-%d %H %M %S')

    tag_text = String.new()
    post_tags.each do |t|
      tag_text << "- #{t}\n"
    end
    post_front_matter['%TAGS%'] = tag_text

    post_name = post_xml.css('post_name').text
    post_front_matter['%SLUG%'] = post_name
    file_name = build_file_name(post_name, post_date)

    post_html = post_xml.css('encoded').text

    # wordpress formatted posts don't have br or p tags, but stuff I wrote
    # in textmate or whatever may so account for that possibility
    post_html.gsub!(/\n/, '<br>') unless post_html.include?('<p>')
    converter = PandocRuby.new(post_html, :from => :html, :to => :markdown)
    post_markdown = converter.convert

    # clean up a few annoying things pandoc is doing
    post_markdown.gsub!(/\\\n/, "\n") # fix linebreaks that are getting escaped too
    post_markdown.gsub!(/\\\$/, '$') # stop trying to escape dollar signs
    post_markdown.gsub!(/\\#/, '#') # fix \# back to #

    puts "writing #{file_name}"
    File.open("output/#{file_name}.md", 'w') do |f|
      f.puts(post_front_matter)
      # f.puts('{{#markdown}}')
      f.puts(post_markdown)
      # f.puts('{{/markdown}}')
    end
  end

  module_function :parse_post, :build_file_name
end


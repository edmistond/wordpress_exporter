require 'pandoc-ruby'
require 'nokogiri'
require 'date'

module WordpressParser

  POST_TEMPLATE = <<EOS
--------
title: %TITLE%
post_date: %POST_DATE%
tags: %TAGS%
--------

EOS

  def build_file_name(post_name, post_date)
    return post_date.strftime("%Y-%m-%d-#{post_name}")
  end

  def parse_post(post_xml, post_tags)
    post_front_matter = String.new(POST_TEMPLATE)

    post_front_matter['%TITLE%']     = post_xml.css('title').text
    post_date                        = DateTime.parse(post_xml.css('pubDate').text)
    post_front_matter['%POST_DATE%'] = post_date.strftime('%Y-%m-%d')
    post_front_matter['%TAGS%']      = post_tags.join(',') #(post_xml.css('category[nicename]').map(&:text)).join(',')

    file_name = build_file_name(post_xml.css('post_name').text, post_date)

    post_html     = post_xml.css('encoded').text
    converter     = PandocRuby.new(post_html, :from => :html, :to => :markdown)
    post_markdown = converter.convert

    puts "writing #{file_name}"
    File.open("output/#{file_name}.md", 'w') do |f|
      f.puts(post_front_matter)
      f.puts(post_markdown)
    end
  end

  module_function :parse_post, :build_file_name
end


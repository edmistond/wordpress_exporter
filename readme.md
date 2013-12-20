## Ruby Wordpress XML Exporter!

This is a little utility for taking an exported Wordpress XML file,
converting all of the entries from HTML to Markdown, and exporting them.

This is kind of inefficient and not really very idiomatic Ruby in places,
I'm afraid. However, the whole purpose of it was just to build a quick and
dirty tool to figure a few things out (while improving my Ruby skills at the
same time) and generate a bunch of Markdown that I can use with 
[http://awestruct.org](Awestruct) for building out my new static site
that I'm working on. However, you could also adjust this to build for
jekyll, assemble.io, or whatever other static site generator you're using.

*This is absolutely not the most efficient implementation for doing this.
Again, didn't care since it's ideally a one time shot.*

You can alter the template for the generated front matter in the POST_TEMPLATE
constant in post.rb.

You could modify this a bit to also import the comments out of a Wordpress
install, too. I did that originally before I realized I didn't really want
to keep the comments anyway and removed that feature.

This is public domain. Do whatever you like with it, but I disclaim any
and all responsibility if you don't like the generated output.
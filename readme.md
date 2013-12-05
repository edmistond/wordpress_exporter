## Ruby Wordpress Importer!

This is a little utility for taking your exported Wordpress XML file,
converting all of the entries from HTML to Markdown, and exporting them.

First, as currently written, it is HORRIBLY inefficient in that it tries to
convert your entire Wordpress XML, with comments, into a collection of arrays
in-memory. If you happen to be a prolific blogger, then this may hurt.

Currently not implemented:
* HTML to Markdown conversion via Pandoc
* Markdown output
* More efficient way of parsing out all the entries - plan to rewrite this so
    it will instead parse out and write each entry from the XML one at a time
    to reduce the pain.

Very much still a work in progress. :)

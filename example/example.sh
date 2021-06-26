#!/bin/sh

# Sourcing the functions
. ../ssg-build

# GENERATING AN INDEX FILE
# 1. The index contents are generated from the Recutils database in
# the form of an HTML list.
# 2. It is given to 'wraphtml' which surrounds the input with the
# template ('template.html') before it is redirected to 'index.html'.
genindex index.rec | wraphtml > index.html

# INDEX ENTIRE DIRECTORY
# 'dirindex' uses the 'find' command to generate an HTML list of all
# files (recursively) in a directory. As with the previous command,
# the HTML output is piped into 'wraphtml' to add the template.
dirindex archive | wraphtml > archiveindex.html

# USING TEMPLATES
wraphtml in_html.html > out_html.html

# MARKDOWN CONVERSION
# The markdown file is converted to HTML using the 'markdown2html'
# before getting redirected to an output file.
markdown2html in_markdown.md | wraphtml > out_markdown.html

# TABLE OF CONTENTS
# A table of contents is generated using the 'gentoc' function before
# it is concatenated with the previous file and redirected to a file.
markdown2html headers.md |
	{ gentoc; markdown2html headers.md ;} |
	wraphtml > headers.html

# RSS FEEDS
# Generating an RSS feed from the in
genrss index.rec -i \
	-t 'Unnamed blog' \
	-u 'https://www.example.com' \
	-d 'My new unnamed personal blog' \
	> rss.xml

#!/bin/sh

. ../ssg-build

genrss index.rec \
	'Unnamed blog' \
	'https://www.example.com' \
	'My new unnamed personal blog' \
	> rss.xml

genindex index.rec > index.html

dirindex archive > archiveindex.html

wraphtml in_html.html > out_html.html

markdown2html in_markdown.md | wraphtml > out_markdown.html

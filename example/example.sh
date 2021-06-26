#!/bin/sh

. ../ssg-build

genindex index.rec | wraphtml > index.html

dirindex archive | wraphtml > archiveindex.html

wraphtml in_html.html > out_html.html

markdown2html in_markdown.md | wraphtml > out_markdown.html

markdown2html headers.md | { gentoc; markdown2html headers.md ;} | wraphtml > headers.html

genrss index.rec \
	-t 'Unnamed blog' \
	-u 'https://www.example.com' \
	-d 'My new unnamed personal blog' \
	> rss.xml

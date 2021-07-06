#!/bin/sh

# After running this script, open the 'index.html' file in a
# webbrowser.

# This section genrates the files used in the example, no commands specific to
# ssg-build are actully run until it is sourced bellow.
cat > template.html <<EOF
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Example</title>
	</head>
	<body>
		<h1>Welcome</h1>
		<hr/>
		<!--WRAPHTML-->
	</body>
</html>
EOF

cat > index.rec <<EOF
%rec: Files
%mandatory: Date File Name
%allowed: Extra
%doc: A list of some example files

Date: 2021-06-11
File: headers.html
Name: Headers

Date: 2021-05-07
File: out_html.html
Name: Example file

Date: 2021-05-25
File: out_markdown.html
Name: example file generated from markdown
Extra: (<a href="in_markdown.md">Original file</a>)

Date: 2021-05-30
File: archiveindex.html
Name: Archive index

Date: 2021-05-30
File: rss.xml
Name: RSS feed

Date: 2021-05-30
File: template.html
Name: The template used for this website
EOF

cat > in_html.html <<EOF
<h1>Lorem ipsum</h1>
<p>
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
</p>
EOF

cat > in_markdown.md <<EOF
# Lorem ipsum
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
culpa qui officia deserunt mollit anim id est laborum.
EOF

cat > headers.md <<EOF
# Lorem
Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor
## ipsum
incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis
### dolor
nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
## sit
Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu
### amet,
fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in
# consectetur
culpa qui officia deserunt mollit anim id est laborum.
###### adipiscing
culpa qui officia deserunt mollit anim id est laborum.
EOF

mkdir archive archive2
i=0
while [ $i -le 5 ]; do
	str="$(tr -dc A-Za-z0-9 < /dev/urandom | head -c 10)"
	cat > "archive/$str.txt" <<-EOF
		$str
		nothing to see here...
	EOF
	i=$((i+1))
done
j=0
while [ $j -le 5 ]; do
	str="$(tr -dc A-Za-z0-9 < /dev/urandom | head -c 10)"
	cat > "archive2/$str.txt" <<-EOF
		$str
		nothing to see here...
	EOF
	j=$((j+1))
done

# SOURCING FUNCTIONS
. ssg-build

# GENERATING RSS FEED
genrss index.rec -i \
	-t 'Unnamed blog' \
	-u 'https://www.example.com' \
	-d 'My new unnamed personal blog' \
	> rss.xml

# GENERATING AN INDEX
genindex index.rec | wraphtml > index.html
# 1. The index contents are generated from the Recutils database in
# the form of an HTML list.
# 2. It is given to 'wraphtml' which surrounds the input with the
# template ('template.html') before it is redirected to 'index.html'.

# INDEX ENTIRE DIRECTORY
dirindex archive archive2 | wraphtml > archiveindex.html
# 'dirindex' uses the 'find' command to generate an HTML list of all
# files (recursively) in a directory. As with the previous command,
# the HTML output is piped into 'wraphtml' to add the template.

# USING TEMPLATES
wraphtml in_html.html > out_html.html

# MARKDOWN CONVERSION
markdown2html in_markdown.md | wraphtml > out_markdown.html
# The markdown file is converted to HTML using the 'markdown2html'
# before getting redirected to an output file.

# TABLE OF CONTENTS
markdown2html headers.md |
{ gentoc; markdown2html headers.md ;} |
wraphtml > headers.html
# A table of contents is generated using the 'gentoc' function before
# it is concatenated with the previous file and redirected to a file.

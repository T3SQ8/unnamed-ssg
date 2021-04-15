# Description
A simple and customizable set of scripts to generate a static site along with
an RSS feed.

# Setup
Choose one of the following methods to utilize the scripts:

1. Add the directory to your `$PATH`. For example, add the following to your
   `~/.profile` file:
```bash
export PATH="$PATH:$HOME/.local/share/unnamed-ssg"
```
2. Use the included makefile to copy files to `/usr/local/bin` by running `make
   install` as root.

## Index database
Create a database file `index.db` with the following syntax:
```
# Lines beginning with hashtag are ignored
+<p>Lines beginning with a dollar sign
+are printed without any change except the leading
+dollar sign getting removed</p>
2021-04-12|file.pdf|Another entry|See <a href="https://example.com">this</a> for more info
2021-04-06|file.html|Test entry|More info <a href="https://example.com">here</a>
```
`$indexsep` can be changed in `ssg-build` to use any other field separator than `|`.

## Templates
### HTML
Create a `template.html` file to be used as a template for all HTML files in
the directory. When the pattern `<!--WRAPHTML-->` is matched on a line by
itself (indentaion does not matter), the HTML file will be injected into the
file by the `wraphtml` script. An example template file could look like this:
```html
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
		<h1>Example file</h1>
		<!--WRAPHTML-->
	</body>
</html>
```
The HTML template file used can be changed in `wraphtml` or with the `-t` option. See the
[Ignored files and exeptions](#ignored-files-and-exeptions) to exclude certain files from this process. The 

### RSS
An RSS feed will also be generated and outputted to `rss.xml`. If the input
file (`$2`) ends with a `.html` extension and is readable, it will be fully
included in the feed as to make it readable from an RSS reader without needing
to open the file in a web browser. Extra HTML (`$4`) will also be included at
the end of the feed entry. The template file (`template.xml`) may look like
this:
```xml
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
	<channel>
		<title>Example feed</title>
		<link>https://example.com</link>
		<link rel="stylesheet" href="css/style.css">
		<description>Example feed</description>
			<!--WRAPHTML-->
	</channel>
</rss>
```
The RSS template file used can be changed with the `-t` option in `ssg-build`.

# Usage
## Website generation
Running `ssg-build` will use the other scripts to generate the website in a
temporary directory. The output directory can be specified using the `-o` flag.
If the output directory already exists, you will be prompted you want to
continue. The prompt can be skipped with the `-f` flag. The following files
will be generated from the example templates [above](#templates):

`index.html`:
```html
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
	</head>
	<body>
		<h1>Example file</h1>
		<!--WRAPHTML-->
		<h3>Lines beginning with a plus sign are made into h3 tags</h3>
		<p>Lines beginning with a dollar sign
		are printed without any change except the leading
		dollar sign getting removed</p>
		<ul>
			<li>
				<b>2021-04-12:</b>
				<a href="file.pdf">Another entry</a>
				See <a href="https://example.com">this</a> for more info
			</li>
			<li>
				<b>2021-04-06:</b>
				<a href="file.html">Test entry</a>
				More info <a href="https://example.com">here</a>
			</li>
		</ul>
	</body>
</html>
```

`rss.xml`:
```xml
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
	<channel>
		<title>Example feed</title>
		<link>https://example.com</link>
		<link rel="stylesheet" href="css/style.css">
		<description>Example feed</description>
		<!--WRAPHTML-->
		<item>
			<title>Another entry</title>
			<link>file.pdf</link>
			<guid>file.pdf</guid>
			<pubDate>2021-04-12</pubDate>
			<description><![CDATA[
			<a href="file.pdf">file.pdf</a>
			See <a href="https://example.com">this</a> for more info
			]]></description>
		</item>
		<item>
			<title>Test entry</title>
			<link>file.html</link>
			<guid>file.html</guid>
			<pubDate>2021-04-06</pubDate>
			<description><![CDATA[
			<h1>Hello</h1>
			<p>This is just some random HTML in <b>file.html</b>.</p>
			More info <a href="https://example.com">here</a>
			]]></description>
		</item>
	</channel>
</rss>
```

**Note:** The generated output (which is added to the template and is not a
part of it) is not indented, indentation was done afterwards in the examples
above.

## Table of contents generator
Every HTML file (except `index.html`) will have a table of contents generated as a list and
prepend to the beginning of the file. The list will have a class name of "toc"
(can be changed in `gentoc`) as to make it customizable with CSS. This can be
disabled by removing `gentoc` from `mvfiles`. See [Ignored files and exeptions](#ignored-files-and-exeptions).

An example HTML file:
```html
<h1>Heading 1</h1>
Lorem ipsum dolor sit amet,
<h2>Heading 2</h2>
consectetur adipiscing elit,
<h3>Heading 3</h3>
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
<h2>Heading 4</h2>
Ut enim ad minim veniam,
<h1>Heading 5</h1>
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
```
Becomes:
```html
<ol class="toc">
	<li>Heading 1</li>
	<ol>
		<li>Heading 2</li>
		<ol>
			<li>Heading 3</li>
		</ol>
		<li>Heading 4</li>
	</ol>
	<li>Heading 5</li>
</ol>
<h1>Heading 1</h1>
Lorem ipsum dolor sit amet,
<h2>Heading 2</h2>
consectetur adipiscing elit,
<h3>Heading 3</h3>
sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
<h2>Heading 4</h2>
Ut enim ad minim veniam,
<h1>Heading 5</h1>
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
```
`gentoc` does not handle indentation. It was done to make afterwards in the example above.

# Ignored files and exeptions
Special handling for specific files is done through a case statement in
`mvfiles` (the files copied, not moved as the name implies).
```bash
# A few variables will be set before the case statement could be usefull incase
# there are multiple differing file extentiones are in use.
case
	# Globs here are copied without changing:
	template.*|archive/*|examples/test.html)
		cp "$infile" "$outfile"
		;;
	# Skipping files:
	*.out)
		continue
		;;
	# An example using the aforementioned variables
	*.md)
		pandoc "$infile" -o "$basename.html"
		;;
	# The general rule for remaining file types
	*)
		cp "$infile" "$outfile"
		;;
esac
```

# Description
A simple set of scripts to generate a static site along with an RSS feed.

# Setup
Choose one of the following methods to utilize the scripts:
1. Uncomment `PATH="$PATH:unnamed-ssg"` and move the repository to the directory you want to use it from.
2. Add the directory to your path. For example, you could add the following to your `.profile`: `export PATH="$PATH:$HOME/.local/share/unnamed-ssg"`.
3. Use the included makefile to copy files to `/usr/local/bin` by running `make install` as root.

# Usage
## Index database
Create a database file `index.db` with the following syntax:
```
# Lines beginning with # Are ignored
+Lines beginning with + are made into h3 tags
# Create entires in the following manner:
# Date|file|entry title|extra HTML
2021-04-02|test.pdf|Test file|(More info <a href="https://example.com">here</a>)
$<p>Lines beginning with
$<code>$</code>
$are printed without changing (except the leading $ being removed)</p>
```
This will result in the following output:
```html
<ul>
</ul>
<h3>Lines beginning with + are made into h3 tags</h3>
<ul>
<li>
<b>2021-04-02:</b>
<a href="test.pdf">Test file</a>
(More info <a href="https://example.com">here</a>)
</li>
</ul>
<p>Lines beginning with
<code>$</code>
are printed without changing (except the leading $ being removed)</p>
<ul>
</ul>
```
`$indexsep` can be changed in `ssg-build` to use any other field separator than `|`

## Templates
### HTML
Create a file called `template.html` that will be used as a template for all
HTML files in the directory. When the pattern `<!--WRAPHTML-->` is matched, the
HTML file will be appended in the middle of the file. An example template file
could look like this:
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
The default template file can be changed in `wraphtml` or with the `-t` option.

### RSS
An RSS feed will also be generated as `rss.xml`
If the input file ($2) is a HTML file, it will be fully included in the feed as
to make the feed readable from and external feed reader without needing to open
the file in a web browser. Extra HTML will also be included at the end of the
feed entry.
```xml
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0">
	<channel>
		<title>Example feed</title>
		<link>https://example.com</link>
		<description>Example feed</description>
			<!--WRAPHTML-->
	</channel>
</rss>
```

# Website generation
Running `ssg-build` will use the other scripts to generate the website in a
temporary directory. The output directory can be specified using the `-o` flag.
If the output directory already exists, you will be prompted you want to continue.
The prompt can be skipped with the `-f` flag.

# Table of contents generator
Every HTML file will have a table of contents generated as a list and
prepend to the beginning of the file. The list will have a class name of "toc"
(can be changed in `gentoc`) as to make it customizable with CSS. This can be
disabled by removing `gentoc` from `mvfiles`.
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
Will become:
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
Special handling for specific files is handled by a case statement in `mvfiles`
(files are not actually moved as the name implies).
```bash
template.*|scripts/*|archive/*) # Globs here are copied without changing
	cp "$infile" "$outfile"
	;;
*.out) # Add files to be skipped
	continue
	;;
*) # The general rule for remaining file types
	cp "$infile" "$outfile"
	;;
```

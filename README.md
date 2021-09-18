A set of simple POSIX shell & AWK scripts for generating websites and RSS
feeds. Unlike other static site generators. It provides the bare minimum to
ensure customizability and flexibility, mainly through user generated templates
and directly modifying the scripts (which isn't as hard as it sounds).

# Installation
use the provided `Makefile` (run `make install` as root) or copy the scripts to
your `$PATH`

# Usage
* `dirindex` -- directory indexer. Generates an HTML list of all files in a directory.
* `genindex` -- index generator. Generates an HTML index file in the form of an unordered list.
* `genrss` -- RSS feed generator. Generates an RSS feed in XML format.
* `gentoc` -- table of contents generator generates a table of contents for a given HTML file. The outermost `<ol>` tag will have the `toc` class so it can be customized with CSS. Note that gentoc only prints the table of contents **without** the actual HTML file.
* `relpath` -- finds relative links in HTML files.
* `markdown2html` -- markdown to HTML generator. Basic markdown syntax to HTML converter using awk.
* `wraphtml` -- wrap html input in a template.

See the included manpages in the `man` directory for usage information and
other details.
```bash
man man/<file>
```

## Quickstart
1. Create an index file in the following format (In this example the file will
   be called `index.db`.): `DATE|TITLE|FILE|EXTRA` (The separator can be
   anything you like, just make sure to change `|` to whatever you chose later
   on.)
```
2021-05-12|Example file 1|/file.html|<a href="https://example.org">More info here</a>
2021-07-23|Example file 2|/file2.html|<a href="https://example.org">See also</a>
```
2. Generate the RSS feed with `genrss`. (Replace the example data with your own.)
```bash
genrss -F'|' -v RSSTitle="Random archive" \
	-v WebsiteURL="https://example.org" \
	-v RSSDescription="Public archive of very important files" \
	index.db > rss.xml
```
1. Generate the index HTML file. (The `index.html` file is also wrapped in the
   template in this case.)
```bash
genindex index.db | wraphtml > index.html
```
1. Wrap the your HTML files in the template (this step is easily automated in a script).
```bash
wraphtml file1_in.html > file1_out.html
wraphtml file2_in.html > file2_out.html
```

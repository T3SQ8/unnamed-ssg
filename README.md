A simple POSIX shell "library" for generating websites and RSS feeds using GNU
Recutils. Unlike other static site generators (which are usually very
opnionated), it provides the bare minimum to ensure customizability and
flexability. This is mainly done through user generated templates, meaning that
both automation (of RSS feeds or homepages) and the ability to change the
content layout though CSS are easily done.

# Dependencies
- [GNU Recutils](https://www.gnu.org/software/recutils)
- Core utilities

# Installation
Copy the `ssg-build` to your `$PATH` or use the included `Makefile` if you
prefer.
```bash
make install
make uninstall
```

# Usage
* `dirindex` -- directory indexer
* `genindex` -- index generator
* `genrss` -- RSS feed generator
* `gentoc` -- table of contents generator
* `markdown2html` -- markdown to HTML generator
* `wraphtml` -- wrap html input in a template

See the included manpages in the `man` directory for usage information.
```bash
man man/<file>
```

## Quickstart
1. Create a Recutils database with the following content (In this example, it
   will be named `index.rec`):
```
%rec: Files
%mandatory: Date File Name

Date: 2021-07-06
File: file2.html
Name: Second example file

Date: 2021-06-24
File: file1.html
Name: First example file
```
1. Create the HTML files you added to the Recutils database. Make sure that
   they **do not** share the same name.
```html
<h1>File1</h1>
<p>Lorem ipsum</p>
```
```html
<h1>File2</h1>
<p>Lorem ipsum</p>
```
1. Create a template HTML file (`template.html`) with you want the previous file to be wrapped
   in. (The pattern `<!--WRAPHTML-->` will be replaced with the HTML file. See
   the documentation for details on how to change this behavior.)
```html
<!DOCTYPE html>
<html lang="en">
	<head>
		<title>Welcome</title>
	</head>
	<body>
		<!--WRAPHTML-->
	</body>
</html>
```
1. Generate the RSS feed.
```bash
genrss -i index.rec > rss.xml
```
1. Generate the index HTML file. (The `index.html` file is also wrapped in the
   template in this case.)
```bash
genindex index.rec | wraphtml > index.html
```
1. Wrap the HTML files in the template.
```bash
wraphtml file1_in.html > file1.html
wraphtml file2_in.html > file2.html
```

## Comprehensive example
To view a demonstration of the available functions, run the `example.sh` script,
then open the newly generated `index.html` file.

# Splitting functions into files
The provided `splitfunc.awk` script will split the functions inside `ssg-build`
into separate files for use where shell functions are accessible (e.g. in a
`Makefile` or when using `xargs`). You can either split the functions and
manage them manually or use the provided command in the makefile.
```bash
make install_split
```


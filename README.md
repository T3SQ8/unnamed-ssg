A simple POSIX shell "library" for generating websites and RSS feeds.

# Dependencies
- [GNU Recutils](https://www.gnu.org/software/recutils)
- [Pandoc](https://pandoc.org/) (If using markdown)

# Installation
Copy the `ssg-build` to your `$PATH` or use the included `Makefile` if you
prefer.
```bash
make install
make uninstall
```

# Usage
1. Create a Recutils database (See [example](#Example))
2. Source `ssg-build` from your interactive shell or in a shell script using one
of the following commands:
```bash
# If file is in your $PATH
. ssg-build
# If file is NOT in your $PATH
. /path/to/file/ssg-build
```

This will give you access to the following functions:
```bash
genindex <index_database>
# Generates an index HTML file from the Recutils database.
genindex index.rec > index.html

genrss [ -t <title> ] [ -u <url> ] [ -d <description> ] <index_database>
# Generates an RSS feed from the Recutils database.
# Miscellaneous metadata can be set using the -t, -u and -d
# flags. Leaving these entries empty will fill them with generic
# data.
genrss index.rec \
	-t 'My RSS feed' \
	-u 'https://www.example.com' \
	-d 'Random Description' \
	> rss.xml

injectindex <index_database>
# Adds the contents of HTML files into the Recutils database under the
# "Contents" field. This can be useful if you want your RSS feed to be readable
# from within the feed reader.
injectindex index.rec | genrss > rss.xml

wraphtml <input> [ -t <template> ] [ -R <regex> ]
# Surrounds the input file with the template file and then prints the file. The
# Regexp which it replaces inside the template can be changes using the -R flag
# (default: ^\s*<!--WRAPHTML-->$). The template file used can be changed with
# the -t flag (default: template.html).
wraphtml file1.html -t template.html -R '^\s*<!--WRAPHTML-->$' > file2.html

dirindex [ -s <format> ] <path>
# Generates an HTML list of all files in a directory. The -s flag can be used
# to change the format which the output is printed in
# (default: <li><a href=\"%p\">%p</a></li>\n). View the printf format section
# under in the find manpage (Run: man find) for more information on the formats
dirindex archive > archiveindex.html

markdown2html <input>
# Converts a markdown file to HTML.
markdown2html file.md > file.html

gentoc <input>
# Generate a table of contents in the form of an HTML list. The outermost <ol>
# tag will have the 'toc' class so it can be customized with CSS.
{ gentoc file1.html; cat file1.html ;} > file2.html
```

# Splitting functions into files
The provided `splitfunc.awk` script will split the functions inside `ssg-build`
into separate files for use where shell functions are accessible. For example
in a `Makefile` or when using `xargs`.
```bash
./splitfunc.awk ssg-build
```

# Example
To view a demonstration of the included functions. `cd` in the `example`
directory and run the `example.sh` script. Then open the newly generated
`index.html` file.
```bash
cd example
sh example.sh
xdg-open index.html
```

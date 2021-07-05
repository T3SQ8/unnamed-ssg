A simple POSIX shell "library" for generating websites and RSS feeds using GNU
Recutils.

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
* `dirindex` -- directory indexer
* `genindex` -- generate index
* `genrss` -- generate RSS feed
* `gentoc` -- generate table of contents
* `injectindex` -- inject into index
* `markdown2html` -- markdown to HTML
* `wraphtml` -- wrap html input in a template

See the included manpages in the `man` directory for usage information.
```bash
man man/<file>
```

# Splitting functions into files
The provided `splitfunc.awk` script will split the functions inside `ssg-build`
into separate files for use where shell functions are accessible. For example
in a `Makefile` or when using `xargs`.
```bash
./splitfunc.awk ssg-build
```

# Example
To view a demonstration of the available functions, run the `example.sh` script,
then open the newly generated `index.html` file.

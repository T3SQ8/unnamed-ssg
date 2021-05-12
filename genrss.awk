#!/usr/bin/awk -f

BEGIN {
	print "<?xml version=\"1.0\" encoding=\"utf-8\"?>"
	print "<rss version=\"2.0\">"
	print "<channel>"
	print "<title>Example title</title>"
	print "<link>https://example.com</link>"
	print "<description>Put information about your website here.</description>"
}

/^[#+]|^$/ {next}

{
	print "<item>"
	print "<title>"$3"</title>"
	print "<link>"$2"</link>"
	print "<guid>"$2"</guid>"
	print "<pubDate>"$1"</pubDate>"
	print "<description><![CDATA["

	if (ext[split($2,ext,".")] == "html" && system("test -f " $2)==0)
		while (getline tmp<$2) {print tmp}
	else
		print "<a href=\""$2"\">"$2"</a>"

	print $4
	print "]]></description>"
	print "</item>"
}

END{
	print "</channel>"
	print "</rss>"
}

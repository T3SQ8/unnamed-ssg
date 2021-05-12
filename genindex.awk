BEGIN {
	print "<ul>"
}

/^#|^$/ { next }

/^\+/ {
	print "</ul>"
	print substr($0, 2)
	print "<ul>"
	next
}

{
	print "<li>"
	printf "<b>%s:</b>\n", $1
	printf "<a href=\"%s\">%s</a>\n", $2, $3
	if ($4) print $4
	print "</li>"
}

END {
	print "</ul>"
}

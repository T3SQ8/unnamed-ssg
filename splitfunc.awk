#!/usr/bin/awk -f

BEGIN {
	FS="("
}

{
	if ($0 ~ /^\w+\(\)\s*{/) {
		output=$1
		print "#!/bin/sh\n" > output
		system("chmod +x " output)
		getline
		while ( $0 !~ /^}$/ ) {
			print $0 > output
			getline
		}
		#printf "Split %s into a separate file\n", output
	}
}

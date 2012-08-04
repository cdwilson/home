#!/bin/bash

: ${MAILDIR:="$HOME/Library/Mail"}

find "$MAILDIR" -type f -name Info.plist -print0 | xargs -0 perl -i -pe 'BEGIN{undef $/;} s/\t<key>SortedDescending<\/key>\n\t<string>NO<\/string>/\t<key>SortedDescending<\/key>\n\t<string>YES<\/string>/smg'

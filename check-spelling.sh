#!/bin/bash
# Copyright (C) 2024 Eric Herman
# License: Attribution-NonCommercial-ShareAlike 4.0 International
# https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode.txt
# SPDX-License-Identifier: CC-BY-NC-SA-4.0

# help set
#       -e  Exit immediately if a command exits with a non-zero status.
#       -x  Print commands and their arguments as they are executed.
if [ "_${VERBOSE}" != "_" ] && [ "${VERBOSE}" -gt 0 ]; then
	set -x
fi
set -e


function git_list_files() {
	# -r Recurse into sub-trees.
	git ls-tree \
		--full-tree \
		-r \
		--name-only \
		HEAD
}

IGNORE_PATTERN="\
^LICENSE.txt$\
\|\.css$\
\|jargon\.txt$\
\|check-.*\.sh$\
\|check-.*\.yml$\
"

ERRORS=0
for FILE in $(git_list_files | grep --invert-match $IGNORE_PATTERN); do
	name=$(basename -- "$FILE")
	extension="${name##*.}"

	if [ "$extension" == "html" ]; then
		MODE=--mode=html
	elif [ "$extension" == "md" ]; then
		MODE=--mode=markdown
	fi
	WORDS=$( aspell $MODE --master=en \
		--home-dir=.  --personal=jargon.txt \
		list < $FILE | sort -u )
	if [ $(echo "$WORDS" | wc -w) -gt 0 ]; then
		echo
		echo "FAIL: $FILE spell check:"
		echo "$WORDS"
		ERRORS=$(( $ERRORS + 1 ))
	fi
done
if [ $ERRORS -gt 0 ]; then
	exit 1
fi

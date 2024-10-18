#!/bin/bash
# Copyright (C) 2024 Eric Herman
# License: Attribution-NonCommercial-ShareAlike 4.0 International
# https://creativecommons.org/licenses/by-nc-sa/4.0/legalcode.txt
# SPDX-License-Identifier: CC-BY-NC-SA-4.0

# help set
#       -e  Exit immediately if a command exits with a non-zero status.
#       -x  Print commands and their arguments as they are executed.
#       -o option-name
#           Set the variable corresponding to option-name:
#               pipefail     the return value of a pipeline is the status of
#                            the last command to exit with a non-zero status,
#                            or zero if no command exited with a non-zero status

if [ -n "${VERBOSE}" ] && [ "${VERBOSE}" -gt 0 ]; then
	set -x
fi
set -e
set -o pipefail


function git_list_files() {
	# -r Recurse into sub-trees.
	git ls-tree \
		--full-tree \
		-r \
		--name-only \
		HEAD
}

ERRORS=0
for FILE in $(git_list_files | grep '\.html$'); do
	if ! tidy -errors -q -f $FILE.errors $FILE; then
		ERRORS=$(( 1 + $ERRORS ))
		echo
		echo $FILE
		cat $FILE.errors
	fi
	rm -f $FILE.errors
done
if [ $ERRORS -gt 0 ]; then
	exit 1
fi

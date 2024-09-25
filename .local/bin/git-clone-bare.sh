#!/usr/bin/env bash

###########################################################################
# Clones a bare repository for use with multiple worktrees
# setting up the following directory structure:
#
# <local-dir-name>/
#	.bare/	# bare repo
#	.git	# "pointer" to bare repo so git works in <local-dir-name>/
#	# worktrees go here, e.g.,
#	main
#	develop
###########################################################################

usage() {
	echo "Usage: $(basename $0) <git-url> <local-dir-name>"
	exit $1
}

# fail fast
set -e

# sanity check args
URL=$1
NAME=$2
[ -z "$URL" ] && usage 1
[ -z "$NAME" ] && usage 2

mkdir $NAME
cd $NAME

# clone bare repository
git clone --bare "$URL" .bare 

# set pointer to bare repo in root
echo "gitdir: ./.bare" > .git

# set remote 'origin' fetch and fetch remote branches
git config remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
git fetch origin

exit 0

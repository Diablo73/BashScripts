# Git-Commands

## Get the commit count across all branches
	git rev-list --all --count

## Get the number of commits grouped by contributors
	git shortlog -s

## Concise form of git log
	git reflog

## git aliases
	alias gpush="git push origin $(git branch --show-current)"
	alias gpull="git pull origin $(git branch --show-current)"

# Git-Commands

## Get the commit count across all branches
	git rev-list --all --count

## Get the number of commits grouped by contributors
	git shortlog -s

## Concise form of git log
	git reflog

## Get the total and concise diff stats in staging area
	git diff --shortstat --staged

## Get the diff stats segregated by files in staging area
	git diff --stat --staged

## Get the diff stats segregated by files in staging area in tabular form
	git diff --numstat --staged

## git aliases
	alias gpush="git push origin $(git branch --show-current)"
	alias gpull="git pull origin $(git branch --show-current)"

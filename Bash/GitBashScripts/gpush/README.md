# gpush

## gpush bash changes
1. *Modify the <`orgName`> in the script to the owner of the repository*
2. *Modify the path in the alias*

## gpush alias
    alias gpush="git push origin $(git branch --show-current) && sh /Users/ashulgupta/Desktop/BashScript/Aliases/gpush.sh $(basename `git rev-parse --show-toplevel`) $(git branch --show-current)"

## gpush warning
1. **After committing, always open a new terminal to run the alias**
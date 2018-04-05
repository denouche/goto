# goto

This is an utils command to allow to jump between local folders

## Installation

First, clone this repository and source the `goto.sh` from your `.bashrc` or any file you want which is sourced when loading a terminal.

For example by adding something like in you `.bashrc`:
```
if [ -f ~/workspace/src/github.com/denouche/goto/goto.sh ]; then
    . ~/workspace/src/github.com/denouche/goto/goto.sh
fi
```

Then, create or modify the `~/.gotorc` file to add your aliases (accepted syntax is describe below)

## .gotorc file syntax

There is two syntaxes you can mix in the `.gotorc` file

### Alias syntax

This syntax is to define custom alias name. The format is:
`aliasname:/path/to/folder`

for example:
```
github:~/workspace/src/github.com
utils:/home/denouche/workspace/src/gitlab.com/denouche-projects/utils
```

You can use either full path definition or path relative to `~` like in the example.

### Find syntax

This syntax allow to search for an exact name into multiple folders. The format is:
`/path/to/folder/*`

for example:
```
/home/denouche/workspace/src/github.com/*
/home/denouche/workspace/src/gitlab.com/*
```

Note you have to use full path definition for this syntax.

## How to use it

Using the following `.gotorc` file:
```
github:~/workspace/src/github.com
utils:~/workspace/src/gitlab.com/denouche-projects/utils
/home/denouche/workspace/src/github.com/*
/home/denouche/workspace/src/gitlab.com/*
```

Then this is some examples and what they will do:
```
$ goto github
## first line of .gotorc file is matching, so it will execute: $ cd ~/workspace/src/github.com
```

```
$ goto goto
## as there is not custom alias matching, this will look into `/home/denouche/workspace/src/github.com/*` and `/home/denouche/workspace/src/gitlab.com/*` to find any matching folder name.
For example in my case it will execute: $ cd /home/denouche/workspace/src/github.com/denouche/goto
```

## Fuzzy matching

For custom alias definition, if you just did a typo while using the command, a fuzzy matching search will be done to try to find the searched folder.
To use this feature, you will need to install `tre-agrep` command.

For example:
```
$ goto gitub ## without the h
## this will execute: $ cd ~/workspace/src/github.com
```




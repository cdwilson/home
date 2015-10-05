# home

Version control and automatic management for user files in `$HOME`

## Table of Contents

* [Overview](#overview)
* [Motivation](#motivation)
* [Setup](#setup)
* [Usage](#usage)
* [How it works](#how-it-works)
    * [Git post-commit hook](#git-post-commit-hook)
    * [update.sh](#update.sh)
* [Terminal.app](#terminalapp)
* [Development](#development)
    * [License](#license)

## Overview

[home] uses [GNU Stow] and [Git] to manage revision controlled files in your home directory (.dotfiles, scripts, etc). Stow is used to automatically maintain all the symbolic links in the user's `$HOME` directory that resolve to actual revision controlled files in the `HOME` directory of this repository.

In addition, there are some other goodies included (like my [Terminal.app](#terminalapp) profile for Mac).


## Motivation

I wanted to be able to keep track of all the random files that end up in my `$HOME` directories on the machines I work on. To avoid turning my `$HOME` directory into a repository itself, I needed to isolate these files in a subdirectory of my `$HOME` directory (i.e. `$HOME/.home`), but I didn't want to have to manually manage symbolic links between the two.  It turns out that Stow works perfectly for this type of thing, hence the dependency on Stow.

Obviously, you probably don't want to use my personal files "as is" on your own machine, so the idea with this repository is that it can serve as an example workflow that you can emulate or fork for your own purposes.


## Setup

* Install `stow` (make sure to use a recent version that supports `--adopt`)

    ```bash
    # via MacPorts for Mac
    sudo port install stow

    # via apt-get for Linux
    sudo apt-get install stow
    ```

* Change to `$HOME` directory

    ```bash
    cd ~
    ```

* Checkout this repository as `$HOME/.home`

    ```bash
    git clone git@github.com:cdwilson/home.git .home
    ```

* Change to `.home` directory

    ```bash
    cd .home
    ```

* Run `setup.sh` to install the git `post-commit` hook. This will also automatically create symlinks between the files in `$HOME/.home/HOME/` and your `$HOME` directory.  It will prompt for permission to move (adopt) any real files in `$HOME` (i.e. existing `.profile`, `.bashrc`, etc) into the `$HOME/.home/HOME/` directory, and replace them with a symlink (see [How it works](#how-it-works) below).

    ```bash
    ./setup.sh
    ```

* Determine any changes between the newly adopted files and the previous revisions of those files stored in the repository

    ```bash
    git status
    ```

* Add any adopted file to keep the version moved from `$HOME`

    ```bash
    git add <any changed files go here>
    ```

* Revert any adopted file to replace the version moved from `$HOME` with the version checked into the repository

    ```bash
    git checkout <any changed files go here>
    ```

* Commit your changes

    ```bash
    git commit -m "<describe your changes here>"
    ```

* You're done! The git `post-commit` hook will automatically update any symlinks in `$HOME` to point to the files in `$HOME/.home/HOME/`


## Usage

Now that everything has been set up, keeping the files in `$HOME` revision controlled is pretty simple:

* Any existing files already tracked in `$HOME/.home/HOME/` can be edited directly or by opening their symlink in your favorite editor.

* Tracking new files in the repository is as simple as copying them from `$HOME` into `$HOME/.home/HOME/`, and committing them into the repository.  The git `post-commit` hook will automatically convert the file in `$HOME` into a symlink.


## How it works

There is no magic going on here--the whole thing boils down to two commands.  [GNU Stow] is used to automatically create symlinks in the user's `$HOME` directory that point to the revision controlled files in `$HOME/.home/HOME/`.

Stow is run in two passes:

1. First, it "stows" `$HOME/.home/HOME/*` into the user's `$HOME` directory by creating symbolic links to all of the files in `$HOME/.home/HOME/`.

    ```bash
    stow --adopt HOME
    ```

    **IMPORTANT:** this first pass is run with the Stow `--adopt` option. If Stow finds a file in the user's `$HOME` directory with the same filename as a file in `$HOME/.home/HOME/`, it will *move* (adopt) the file from the user's `$HOME` directory into `$HOME/.home/HOME/` and replace it with a symbolic link in `$HOME`. It will overwrite any existing files in `$HOME/.home/HOME/` without asking! While this is normally the behavior we want, if you're not careful, it has the potential to overwrite any unstaged changes in the repository. If you don't want this behavior simply remove `--adopt` from the command in the hook file.

2. Second, Stow is re-run with the `-R` option. This causes Stow to "restow" all the files in `HOME` ensuring any stale links are pruned.

    ```bash
    stow --restow HOME
    ```

These commands must be run in this sequence and can not be combined (i.e. `stow --adopt --restow HOME`) to avoid errors when `$HOME` and `$HOME/.home/HOME/` have conflicting files.


### Git post-commit hook

There is a Git `post-commit` installed by `setup.sh` to run Stow automatically after committing changes to the repository. This makes sure that the symbolic links in `$HOME` are kept up to date and any new files are actually moved into the repository (as opposed to accidentally leaving a copy in `$HOME` and a separate copy in the repository).  Under the hood, the `post-commit` hook just runs the two stow commands described above.


### update.sh

If for some reason you need to update the symlinks in `$HOME` without actually committing anything to the repository, running `update.sh` runs the same stow commands as the git `post-commit` hook, prompting whether or not to bypass adopting files from `$HOME`.  Any arguments passed to `update.sh` are passed to the internal stow commands (e.g. to display stow action details, run `./update.sh --verbose`)


## Terminal.app

![][cdwilson.terminal]

To use the Terminal.app profile shown in the photo above, just double click the `terminal/cdwilson.terminal` file in Finder.


## Development

[home] is hosted by [GitHub]

Please feel free to submit pull requests and file bugs on the [issue tracker].


### License

The MIT License (MIT)

Copyright (c) 2013 Christopher Wilson

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.


[GitHub]: http://github.com
[home]: http://github.com/cdwilson/home
[issue tracker]: http://github.com/cdwilson/home/issues
[GNU Stow]: http://www.gnu.org/software/stow/
[Git]: http://git-scm.com/
[cdwilson.terminal]: images/cdwilson.terminal.png "cdwilson Terminal.app preferences"

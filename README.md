home
====

by Christopher Wilson  
<cwilson@cdwilson.us>

overview
--------
home uses [GNU Stow](http://www.gnu.org/software/stow/) and
[Git](http://git-scm.com/) to manage revision controlled files in your home
directory (.dotfiles, scripts, etc). Stow is used to automatically maintain
all the symbolic links in the user's `$HOME` directory that resolve to the
actual revision controlled files in the `HOME` directory of the repository.

motivation
----------
I wanted to be able to keep track of all the random files that end up in my
`$HOME` directories on the machines I work on. I didn't want to have to
manually manage symbolic links, hence the dependency on Stow. Obviously, you
probably don't want to use my personal files "as is" on your own machine, so
the idea with this repository is that it can serve as an example that you can
emulate or fork for your own purposes.

hooks
-----
For convenience, there is also a Git `post-commit` hook supplied to run Stow
automatically after checking in changes to the repository. This makes sure
that the symbolic links in `$HOME` are kept up to date and any new files are
actually moved into the repository (as opposed to accidentally leaving a copy
in `$HOME` and a separate copy in the repository). The `post-commit` hook runs
Stow in two passes.

First, it "stows" the repository `HOME` directory into the user's `$HOME`
directory by creating symbolic links to all of the files in the repository
`HOME` directory.

*IMPORTANT:* this first pass is run with the Stow `--adopt` option. Therefore,
if Stow finds a file in the user's `$HOME` directory with the same filename as
a file in the repository `HOME` directory, it will *move* the file from the
user's `$HOME` directory into the repository `HOME` directory (i.e. "adopt"
it) and replace it with a symbolic link. It will overwrite any existing files
in the repository `HOME` directory without asking! While this is useful when
setting up a new system, if you're not careful, it has the potential to
overwrite any unstaged changes in the repository. If you don't want this
behavior simply remove `--adopt` from the command in the hook file.

Second, Stow is re-run with the `-R` option. This causes Stow to
"restow" all the files in `HOME` ensuring any stale links are pruned.

setup and usage
---------------

* install stow (make sure to use a recent version that supports `--adopt`)
* checkout this repository as `$HOME/.home`
* make `post-commit` hook executable and copy it to `$HOME/.home/.git/hooks/post-commit`
* use stow to "adopt" any existing files in the repository
* copy new files you want tracked into `$HOME/.home/HOME/` and when you commit
  they will be automatically "adopted" and converted into symlinks
* edit your files in `$HOME/.home/HOME/` and remember to commit to force stow
  to update any symbolic links that have changed!

example
-------

    # change to $HOME dir
	cd ~
	# checkout home.git as .home
    git clone git@github.com:cdwilson/home.git .home
	# change directory to .home
	cd .home
	# add execute permissions to post-commit hook
	chmod +x post-commit
	# copy post-commit hook into hooks dir so that it will be run after each
	# commit to this repository
	cp post-commit .git/hooks/
	# "adopt" any plain files that are in $HOME, but not yet in the repository,
	# by moving them into .home/HOME and replacing them with a symlink
	stow -v --adopt HOME
	# restow to prune any stale symlinks
	stow -v -R HOME
	# run `git status` to view any changes between the newly adopted files and
	# the ones checked into the repository
	git status
	# add any changes
	git add <your changed files go here>
	# commit your changes
	git commit -m "these are my changes"
	# You're done! post-commit will automatically update the symlinks

# Bash Shell

![][Tanooki Mario with Shell]

[home] makes the assumption that a relatively recent[^bash_completion] version of Bash is used for the shell.  

This article is an attempt to answer the following questions:

* What is the difference between `~/.profile`, `~/.bash_profile`, `~/.bash_login`, and `~/.bashrc`?
* Why doesn't Terminal read my `~/.bashrc` on Mac OS X?

For more detailed information, see [Bash Startup Files] and [LFS profile]

If you're wondering, "why Bash?", see [Shell Script Basics] from the [Mac Developer Library].


## Bash startup

When Bash is invoked, it reads and executes commands from its startup files to set up the shell environment.  

There are two conditions Bash uses to determine which startup files are read (or ignored) when the shell session is started:

* *Am I a login shell?*
    * first character of argument zero is a `-`
    * started with the `--login` option

* *Am I an interactive shell?*
    * started without non-option arguments and without the `-c option`, whose standard input and error are both connected  to terminals
    * started with the -i option

Said very simply, a _login shell_ is one that asks you to login (username/password), and an _interactive shell_ is one you type commands into (i.e. interact with).


## Default Behavior

On most Linux systems, you login to the system via an _interactive login shell_.  First, the login shell sources `/etc/profile`, if that file exists.   Next, it looks for any of the following files in this order: `~/.bash_profile`, `~/.bash_login`, `~/.profile`.  If it finds one that exists and is readable, Bash sources the file.

Upon successful login to the machine, a shell window is usually started with a terminal program like `xterm` or `konsole` from within the graphical environment.  Since we've already logged in, this new shell window is usually run as an _interactive non-login shell_, meaning `~/.bash_profile` is not read when Bash is invoked.  Instead, Bash expects settings for non-login shells to be put in `~/.bashrc`, so it reads and executes this file (if the file exists).

If you have settings in `~/.bashrc` that should be run for both login and non-login sessions, you need to add the following to `~/.bash_profile`:

```bash
# if this is an interactive shell include ~/.bashrc
[[ $- == *i* ]] && . $HOME/.bashrc
```

Additionally, when a login shell exits, Bash reads and executes commands from the file `~/.bash_logout`, if it exists.


## Mac

Of course, Terminal.app on Mac [thinks different]...

When you launch Terminal, a new window opens and runs the shell specified in the Preferences.[^bash_completion]  By default, shells open with the default login shell (`/usr/bin/login`).  Therefore, since Terminal starts each new window as an interactive login shell, `~/.bash_profile` is sourced while `~/.bashrc` is NOT (unless you source `~/.bashrc` from within `~/.bash_profile` as shown above).


[Tanooki Mario with Shell]: images/tanooki_mario_shell.gif "Tanooki Mario with Shell"
[home]: http://github.com/cdwilson/home
[Shell Script Basics]: https://developer.apple.com/library/mac/documentation/opensource/conceptual/shellscripting/shell_scripts/shell_scripts.html#//apple_ref/doc/uid/TP40004268-CH237-SW3
[Mac Developer Library]: https://developer.apple.com/library/mac/navigation/
[Bash Startup Files]: https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html
[thinks different]: http://www.youtube.com/watch?v=nmwXdGm89Tk
[Bash Completion How To]: http://trac.macports.org/wiki/howto/bash-completion
[LFS profile]: http://www.linuxfromscratch.org/blfs/view/svn/postlfs/profile.html

[^bash_completion]: Bash completion from MacPorts requires Bash version 4.1 or later, and at the time of this writing, the version of Bash that ships with OS X is too old (3.2.51(1)-release on Mavericks).  Make sure to toggle _Terminal_ -> _Preferences_ -> _Startup_ -> _Shells open with_ to _Command (complete path):_ `/opt/local/bin/bash`
For more details, see the [Bash Completion How To]

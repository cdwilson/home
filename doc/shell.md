SHELL
=====

![](images/tanooki_mario_shell.gif)


HELP!
-----

* What is the difference between `~/.profile`, `~/.bash_profile`, and `~/.bashrc`?
* Why doesn't Terminal read my `~/.bashrc` on Mac OS X?


Bash startup
------------

The [Bash manual](https://www.gnu.org/software/bash/manual/) gives an overview of [Bash Startup Files](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html), but it took me a few reads to really understand how everything works.  The following is an attempt at a more linear explanation of the shell startup sequence.

When Bash is invoked, it reads and executes commands from its startup files to create an environment.  

There are two conditions that determine which startup files are read (or ignored) when the shell is started:

Login shell
: - first character of argument zero is a `-`
: - started with the `--login` option

Interactive shell
: - started without non-option arguments and without the `-c option`, whose standard input and error are both connected  to terminals
: - one started with the -i option

Said very simply, an _interactive shell_ is one you type commands into, and the shell you use to log into the computer is an _interactive login shell_.  


Linux
-----

On most Linux systems, you login to the system via an _interactive login shell_.  By default, the login shell reads and executes commands from the file `/etc/profile`, if that file exists.   Next, it looks for any of the following files in this order:

```bash
~/.bash_profile
~/.bash_login
~/.profile
```

If it finds one that exists and is readable, Bash executes the commands in the file.

Upon successful login to the machine, a shell window is usually started with a terminal program like `xterm` or `konsole` from within the graphical environment.  Since we've already logged in, this new shell window is an _interactive non-login shell_, meaning `~/.bash_profile` is not read when Bash is invoked.  Bash expects settings for non-login shells to be put in `~/.bashrc`, so it reads this file instead and executes the commands (if the file exists).

If you have settings in `~/.bashrc` that should be run on login, you need to add the following to `~/.bash_profile`:

```bash
# if this is an interactive shell include ~/.bashrc
[[ $- == *i* ]] && . $HOME/.bashrc
```


OS X
----

Of course, Terminal.app on OS X [thinks different](http://www.youtube.com/watch?v=nmwXdGm89Tk)...

When you launch Terminal, a new window opens and runs the shell specified in the Preferences.[^bash_completion]  However, by default, shells open with the default login shell.  Therefore, since Terminal starts as an interactive login shell, `~/.bash_profile` is read and executed while `~/.bashrc` is NOT (unless you source `~/.bashrc` from within `~/.bash_profile` as shown above).

[^bash_completion]: Bash completion from MacPorts requires Bash version 4.1 or later, and at the time of this writing, the version of Bash that ships with OS X is too old (3.2.51(1)-release on Mavericks).  Make sure to toggle _Terminal_ -> _Preferences_ -> _Startup_ -> _Shells open with_ to _Command (complete path):_ `/opt/local/bin/bash`
For more details, see the [Bash Completion How To](http://trac.macports.org/wiki/howto/bash-completion)

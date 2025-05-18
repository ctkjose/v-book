**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Installing V {menu:topics;menu-id:intro}

The easiest way to get started programming with V is to install V from the pre-build binaries. Pre-compiled binaries are built every week and available for download from [here](https://github.com/vlang/v/releases).

After installing the V binaries you want to add V to you path by running the following command. On MacOS/Unix systems we run `sudo ./v symlink` to add the V binary to `/usr/local/bin/v`. On Windows, start a new shell with administrative privileges, for example by pressing the Windows Key, then type cmd.exe, right-click on its menu entry, and choose Run as administrator. In the new administrative shell, cd to the path where you downloaded V, then type: `v symlink`.

More advance users can build V from its source code which is quite simple.


# Building from sources {menu:topics}

## Installing GIT {menu:topics}

The latest code for V is maintained in a GIT repository. If you plan to work with V's source code or use git with your own projects it is a must.

The official instructions on how to install [git](https://git-scm.com) are available [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

### MacOS

On MacOS (Mavericks 10.9 or newer) git is part of [**Xcode or the Command Line Tools**](https://developer.apple.com/xcode/). If this is the first time on the Terminal type `git --version`. If you don’t have it installed already, it will prompt you to install it.

If you have [Homebrew](https://brew.sh) you can also do `brew install git`.

### Linux

If you are on a Debian-based distribution, such as Ubuntu, the following command usually works: `sudo apt install git-all`.

### Windows

On Windows you can download the Git installer from [here]( https://git-scm.com/download/win).




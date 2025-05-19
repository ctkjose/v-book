**V Book** | [Home](./index.md) | [Translations](./book_versions.md) | V-LANG 0.4.10<BR>

# Installing V {menu:topics;menu-id:intro}

The easiest way to get started programming with V is to install V from the pre-build binaries. Pre-compiled binaries are built every week and available for download from [here](https://github.com/vlang/v/releases).

After installing the V binaries you want to add V to you path by running the following command. On MacOS/Unix systems we run `sudo ./v symlink` to add the V binary to `/usr/local/bin/v`. On Windows, start a new shell with administrative privileges, for example by pressing the Windows Key, then type cmd.exe, right-click on its menu entry, and choose Run as administrator. In the new administrative shell, cd to the path where you downloaded V, then type: `v symlink`.

More advance users can build V from its source code which is quite simple.

## Windows requirements {menu:topics;menu-id:win_notes}

V uses recent Windows features like UTF-8 and color output support in console, IPv6 and native TLS support on sockets, etc. Windows 10 Fall Creators Update (1709) or later is the recommended Windows version for best compatibility. Previous versions are supported as well, but are not as well tested and may lack some features.


# Building from sources {menu:topics}

## Installing GIT {menu:topics}

The latest code for V is maintained in a GIT repository. If you plan to work with V's source code or use git with your own projects it is a must.

The official instructions on how to install [git](https://git-scm.com) are available [here](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git).

### MacOS

On MacOS (Mavericks 10.9 or newer) git is part of [**Xcode or the Command Line Tools**](https://developer.apple.com/xcode/). If this is the first time on the Terminal type `git --version`. If you don’t have it installed already, it will prompt you to install it.

If you have [Homebrew](https://brew.sh) you can also do `brew install git`.

### Linux Systems

If you are on a Debian-based distribution, such as Ubuntu, the following command usually works: `sudo apt install git-all`. On ArchLinux use `pacman -Sy git`.

### Windows

On Windows you can download the Git installer from [here]( https://git-scm.com/download/win).


## Installing a C development environment {menu:topics}

### MacOS

On MacOS, V uses the [**clang**](https://en.wikipedia.org/wiki/Clang) toolchain with libc.

You can install the core development tools know as **Xcode Command Line Tools** alone, however, if you intend to use Apple's API and frameworks you will need to install the full Xcode from the Apple Store.

> If you use **Homebrew**, the popular Mac package manager, Homebrew will install Xcode Command Line Tools as part of its installation process.

To install the command line tools open the Terminal and type this command `xcode-select –-install`.

### Linux Systems

On Linux, V uses the tool chains provided by the GNU Compiler Collection, **gcc** in particular. We also need the GNU C Library commonly known as **glibc**.

| System | Command | Notes |
| --- | --- | --- |
| ArchLinux | `pacman -Sy gcc glibc make git` | |
| Debian/Ubuntu | `sudo apt install build-essential` | |
| Centos/RedHat | `yum install gcc glibc-devel git` | |

To check your installation run the following command `gcc --version`. You should see the compiler version details on the screen.

### Windows

In Windows, when you install V using `make.bat` the TCC compiler will be downloaded by default. The TCC compiler is a small compiler that works but is not intended for production code. One of the main limitations of TCC is the lack of code optimizations.

> Please note that the [original TCC](https://repo.or.cz/tinycc.git) isn't fully compatible with V, and V distributes its own [patched binary](https://github.com/vlang/tccbin/tree/thirdparty-windows-amd64).

Visual Studio is your best choice in particular if you plan to use the Windows SDK/WinAPI.

Download the [community edition](https://visualstudio.microsoft.com/vs/).

> In the installer select **Visual Studio core editor**, **Desktop development with C++**, and **Windows 11 SDK**.

> **Building on Windows ARM**: Check this [wiki page](https://github.com/vlang/v/wiki/Workaround-for-building-V-on-Windows-ARM) if you are getting errors using Windows ARM.

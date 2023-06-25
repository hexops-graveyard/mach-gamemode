# mach/gamemode - leverage Linux gamemode from Zig

`mach/gamemode` allows Linux games written in Zig to _request gamemode be enabled_ if the user's machine already has it installed/present. Otherwise, it simply does nothing (there are no dependencies and your game will still run on all Linux machines that do not have gamemode installed.)

This is preferred as it means your game will automatically invoke gamemode for the user when running, rather than them having to manually enable it.

This repository is a separate copy of the same library in the [main Mach repository](https://github.com/hexops/mach), and is automatically kept in sync, so that anyone can use this library in their own project if they like!

## What is Linux GameMode?

Used by titles such as DiRT 4, and many Tomb Raider and Total War games, [GameMode](https://github.com/FeralInteractive/gamemode) is a daemon/lib combo for Linux that allows games to request a set of optimisations be temporarily applied to the host OS and/or a game process, including:

>     CPU governor
>     I/O priority
>     Process niceness
>     Kernel scheduler (SCHED_ISO)
>     Screensaver inhibiting
>     GPU performance mode (NVIDIA and AMD), GPU overclocking (NVIDIA)
>     Custom scripts

GameMode packages are available for Ubuntu, Debian, Solus, Arch, Gentoo, Fedora, OpenSUSE, Mageia and possibly more.

## Experimental

This is an _experimental_ Mach library, according to our [stability guarantees](https://machengine.org/next/docs/libs/):

> Experimental libraries may have their APIs change without much notice, and you may have to look at recent changes in order to update your code.

[Why this library is not declared stable yet](https://machengine.org/next/docs/libs/experimental/#gamemode)

## Getting started

### Adding dependency

Create a `build.zig.zon` file in your project (replace `$LATEST_COMMIT` with the latest commit hash):

```
.{
    .name = "mypkg",
    .version = "0.1.0",
    .dependencies = .{
        .vulkan_zig_generated = .{
            .url = "https://github.com/hexops/mach-gamemode/archive/$LATEST_COMMIT.tar.gz",
        },
    },
}
```

Run `zig build` in your project, and the compiler instruct you to add a `.hash = "..."` field next to `.url`.

Then use the dependency in your `build.zig`:

```zig
...
pub fn build(b: *Build) void {
    ...
    exe.addModule("mach-gamemode", b.dependency("mach_gamemode", .{
        .target = target,
        .optimize = optimize,
    }).module("mach-gamemode"));
}
```

You may then `const gamemode = @import("mach-gamemode");` and use it.

### Usage

https://github.com/hexops/mach/issues/820

## Join the community

Join the Mach community [on Discord](https://discord.gg/XNG3NZgCqp) to discuss this project, ask questions, get help, etc.

## Issues

Issues are tracked in the [main Mach repository](https://github.com/hexops/mach/issues?q=is%3Aissue+is%3Aopen+label%3Agamemode).

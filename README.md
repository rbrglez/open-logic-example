# Open Logic Example

This repository demonstrates different ways to include the Open Logic library with FuseSoC in your project.

## Remote Cores

This is the lightweight approach for including the Open Logic library. You only need to add `*.core` files to your repository, so there's no need to include the entire Open Logic repository as a git submodule.

Check out the `remote-cores` directory to see the files you need to add.

To test the functionality with remote cores, a `Makefile` is provided:

```bash
make init-remote-stable-open-logic
make init-my-target
make run-stable-target
```

## Local Cores

In this option, you need to add the entire Open Logic repository as a git submodule to your project. After that, you can add the submodule as a FuseSoC library.

Check out the `local-cores` directory for the necessary setup.

To test the functionality with local cores, the following `Makefile` commands are provided:

```bash
make init-local-stable-open-logic
make init-my-target
make run-stable-target
```


## WARNING: Stable Cores use development files!!!

How to recreate this behaviour:

### 1) with fusesoc add appropriate libraries

```bash
make init-local-dev-open-logic
make init-my-target
```

### 2) Modify development files

To see the difference between stable and development files modify `local-cores/development/src/axi/olo_axi_master_full.vhd`
For example just add a dummy comment.

Now use fusesoc `run` command or `Makefile` wrapper

```bash
make run-stable-target
```

This command will download stable open-logic repository to `~/.cache/fusesoc`, but it won't use those files!

Check out which files were actually used:
`build/my_target_0.1.0/axi-target-vivado/src/open-logic_open-logic_axi_3.0.2/vhdl/olo_axi_master_full.vhd`


## Creating Custom Remote Cores

Check out `remote-cores/development/custom-open-logic/olo_fifo.core`.

`olo_fifo.core` is a custom core based on `olo_base.core`, but with a focus solely on FIFO files and their dependencies. It demonstrates an important behavior of core files managed by FuseSoC.

When a core file includes a `provider` key, it changes the way source files are resolved. Instead of searching for source files within the local directory of the core file itself, FuseSoC will download the entire repository specified in the provider key to the `~/.cache/fusesoc` directory.

From there, FuseSoC will reference and add source files starting from the top-level directory of the downloaded repository, not from the local directory where the core file resides.

This behavior is crucial to understand when working with core files that rely on external repositories for their source files, as it can affect how and where the source files are retrieved during the build process.

Previously, the behavior was somewhat unclear due to the existence of both `olo_base.core` and `olo_base_dev.core`.

- `olo_base.core` included a `provider` key, which caused FuseSoC to download the entire repository to `~/.cache/fusesoc`.
- `olo_base_dev.core`, on the other hand, did not include the `provider` key, so it sourced files locally.

It's important to note that `olo_base.core` (the one with the `provider` key) has no direct connection to the `olo_base.core` file in the downloaded repository located in `~/.cache/fusesoc`. As a result, the core file **MUST** specify the full path from the root of the downloaded repository to the files it wants to include. 

**Why Did This Work Previously?**

You might wonder why this setup worked without errors even though the paths in olo_base.core were incorrect. When the repository was downloaded, FuseSoC initially attempted to locate the source files within the downloaded repository. When it couldn't find them there, it looked in the current directory.

However, this fallback mechanism didn't retrieve the correct files; instead, it found the development files. This is why the process appeared to work, but it was actually pulling in the wrong files — the development versions — instead of the intended production sources.


### How to use custom remote cores

```bash
make init-remote-custom-open-logic-fifo
make init-my-target
make run-custom-fifo-target
```
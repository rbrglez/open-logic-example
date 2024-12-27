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

This command will download stable open-logic repository to `~/.local/fusesoc`, but it won't use those files!

Check out which files were actually used:
`build/my_target_0.1.0/axi-target-vivado/src/open-logic_open-logic_axi_3.0.2/vhdl/olo_axi_master_full.vhd`
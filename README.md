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

.PHONY: init-local-stable-open-logic
.PHONY: init-local-dev-open-logic
.PHONY: init-remote-stable-open-logic
.PHONY: init-remote-dev-open-logic
.PHONY: init-my-target
.PHONY: run-dev-target
.PHONY: run-stable-target
.PHONY: list-cores
.PHONY: clean

init-local-stable-open-logic:
	fusesoc library add local-stable-open-logic local-cores/stable/open-logic

init-local-dev-open-logic:
	fusesoc library add local-dev-open-logic local-cores/development/open-logic

init-remote-stable-open-logic:
	fusesoc library add remote-stable-open-logic remote-cores/stable/open-logic-3.0.2

init-remote-dev-open-logic:
	fusesoc library add remote-dev-open-logic remote-cores/development/open-logic-3.0.2

init-my-target:
	fusesoc library add my-target my-target

run-dev-target:
	fusesoc run --target axi-dev-target --setup my_target

run-stable-target:
	fusesoc run --target axi-target --setup my_target

list-cores:
	fusesoc core list

clean:
	rm -rf fusesoc.conf
	rm -rf build/
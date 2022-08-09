rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

TARGET=build/toolbox.ex.sh

.PHONY: build
build: build/toolbox.ex.sh

.PHONY: test
test: build
	@echo "[*] Executing toolbox with argument: $(ARGS)"
	@./$(TARGET) -t build/bin.tar $(ARGS)

build/toolbox.ex.sh: build/toolbox.prog.sh
	@echo "[+] Making $@"
	@echo "#!/bin/bash" > $@
	@echo "set -e" >> $@
	@cat $^ >> $@
	@chmod +x $@

build/toolbox.sh: build/toolbox.prog.sh build/bin.tar
	@echo "[+] Making toolbox.sh"
	@echo "#!/bin/bash" > $@
	@echo "set -e" >> $@
	@cat build/toolbox.prog.sh >> $@
	@echo "exit 0" >> $@
	@echo "__EMBED_FILE__" >> $@
	@cat build/bin.tar | base64 >> $@
	@chmod +x $@

build/toolbox.prog.sh: $(call rwildcard,src,*)
	@echo "[+] Making toolbox.prog.sh"
	@cpp src/_entry.sh > $@

build/bin.tar: $(wildcard bin/*)
	@$(MAKE) -C $(CURDIR)/bin
	@mv bin/bin.tar build/bin.tar
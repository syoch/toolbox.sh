rwildcard=$(foreach d,$(wildcard $(1:=/*)),$(call rwildcard,$d,$2) $(filter $(subst *,%,$2),$d))

.PHONY: build
build: build/toolbox.sh

.PHONY: test
test: build
	./build/toolbox.sh $(ARGS)

build/toolbox.sh: build/toolbox.prog.sh build/bin.tar
	echo "#!/bin/bash" > $@
	echo "set -e" >> $@
	cat build/toolbox.prog.sh >> $@
	echo "exit 0" >> $@
	echo "__EMBED__FILE__" >> $@
	cat build/bin.tar | base64 >> $@

	chmod +x $@

build/toolbox.prog.sh: $(call rwildcard,src,*)
	cpp src/_entry.sh > $@

build/bin.tar: $(wildcard bin/*)
	$(MAKE) -C $(CURDIR)/bin
	mv bin/bin.tar build/bin.tar
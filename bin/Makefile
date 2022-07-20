bin_files := $(wildcard *)
bin_files := $(filter-out Makefile,$(bin_files))

bin.tar: $(bin_files)
	@echo "[+] Making bin.tar with $^"
	@tar -czf $@ $^
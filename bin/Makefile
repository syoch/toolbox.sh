bin_files := $(wildcard *)
bin_files := $(filter-out Makefile,$(bin_files))
bin_files := $(filter-out .gitignore,$(bin_files))

bin.tar: $(bin_files)
	tar -czf $@ $^
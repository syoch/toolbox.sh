function load_tar_commands {
  for name in $(tar_commands); do
    @l $name tar:$name tar_execute Execute $name from tar archive
  done
}
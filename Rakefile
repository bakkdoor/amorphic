desc "Deletes all .fyc files."
task :clean do
  compiled = Dir.glob("**/*.{rbc,fyc}")
  rm_f compiled, :verbose => true
end

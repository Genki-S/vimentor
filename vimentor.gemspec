Gem::Specification.new do |s|
  s.name        = "vimentor"
  s.version     = "0.0.0"
  s.summary     = "More than vimtutor"
  s.description = "Train you to be more effective"
  s.authors     = ["Genki Sugimoto"]
  s.email       = ""
  s.homepage    = ""

  s.files       = `git ls-files`.split("\n")
  s.executables = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
end

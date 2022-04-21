lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "backup/version"

Gem::Specification.new do |spec|
  spec.name          = "backup"
  spec.version       = Backup::VERSION
  spec.authors       = ["Zhon"]
  spec.email         = ["zhon@xmisson.com"]

  spec.summary       = %q{Backup images from server to a backup drive}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/zhon/backup"

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/zhon/backup"
  spec.metadata["changelog_uri"] = "https://github.com/zhon/backup/blob/master/README.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "threadpool"
  spec.add_dependency "timeout"


  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rr", "~> 3.0"
  spec.add_development_dependency "rantly", "~> 2"
  spec.add_development_dependency "timecop", "~> 0.9"
  spec.add_development_dependency "guard", "~> 2.0"
  spec.add_development_dependency "guard-minitest", "~> 2.0"
end

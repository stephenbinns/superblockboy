# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "gosu"
  s.version = "0.8.7.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Julian Raschke"]
  s.date = "2015-01-19"
  s.description = "    2D game development library.\n\n    Gosu features easy to use and game-friendly interfaces to 2D graphics\n    and text (accelerated by 3D hardware), sound samples and music as well as\n    keyboard, mouse and gamepad/joystick input.\n\n    Also includes demos for integration with RMagick, Chipmunk and OpenGL.\n"
  s.email = "julian@raschke.de"
  s.extensions = ["ext/gosu/extconf.rb"]
  s.files = ["ext/gosu/extconf.rb"]
  s.homepage = "http://www.libgosu.org/"
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.8.2")
  s.rubygems_version = "2.0.14"
  s.summary = "2D game development library."
end

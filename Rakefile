task :build_standalone do
  rm_rf 'pkg/osx'
  mkdir 'pkg/osx'

  `unzip wrappers/Ruby.app.zip -d pkg/osx`

  cp_r Dir.glob('*.rb'), 'pkg/osx/Ruby.app/Contents/Resources/'
  cp_r Dir.glob('*.yml'), 'pkg/osx/Ruby.app/Contents/Resources/'
  cp_r Dir.glob('lib/*.rb'), 'pkg/osx/Ruby.app/Contents/Resources/lib/'
  mkdir 'pkg/osx/Ruby.app/Contents/Resources/media'

  # dirty gem loading
  cp_r Dir.glob('vendor/bundle/ruby/*/gems/chingu-*/lib/*'), 'pkg/osx/Ruby.app/Contents/Resources/lib/'
  cp_r Dir.glob('vendor/bundle/ruby/*/gems/rest-client-*/lib/*'), 'pkg/osx/Ruby.app/Contents/Resources/lib/'
  cp_r Dir.glob('vendor/bundle/ruby/*/gems/mime-types-*/lib/*'), 'pkg/osx/Ruby.app/Contents/Resources/lib/'
  cp_r Dir.glob('vendor/bundle/ruby/*/gems/netrc-*/lib/*'), 'pkg/osx/Ruby.app/Contents/Resources/lib/'
  cp_r Dir.glob('vendor/bundle/ruby/*/gems/crack-*/lib/*'), 'pkg/osx/Ruby.app/Contents/Resources/lib/'

  # copy all media
  cp_r Dir.glob('media/*.*'), 'pkg/osx/Ruby.app/Contents/Resources/media/'

  cd 'pkg/osx/Ruby.app/Contents/Resources/'
  rm 'main.rb'
  mv 'game.rb', 'main.rb'

  cd '../../..'
  mv 'Ruby.app', 'BlockBoy.app'
end

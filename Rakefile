require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "video_metadata"
    gem.summary = %Q{Wraps several video metadata sources into one interface}
    gem.description = %Q{Currently handles imdb,tmdb,tvdb and myanimelist}
    gem.email = "fridrik01@gmail.com"
    gem.homepage = "http://github.com/frikkasoft/video_metadata"
    gem.authors = ["Friðrik Ásmundsson"]
    
    gem.add_dependency('yayimdbs', '>= 0.1.7')
    gem.add_dependency('tmdb_party', '>= 0.4.1')
    gem.add_dependency('tvdb_party', '~> 0.3.2')
    gem.add_dependency('htmlentities', '>= 4.2.0')    
    gem.add_dependency('rest-client', '>= 1.4.2')    
  end
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/*_test.rb'
  test.verbose = true
end

task :test => :check_dependencies

task :default => :test

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION')
    version = File.read('VERSION')
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "video_metadata #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/*.rb')
end

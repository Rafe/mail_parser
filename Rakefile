require "rake"

#setup rake tasks for jeweler
begin
  require "jeweler"
  Jeweler::Tasks.new do |gem|
    gem.name = "mail_parser"
    gem.summary = "Parser for parsing imformation by regex in mail"
    gem.description = "Parser for parsing imformation by regex in mail"
    gem.email = ""
    gem.homepage = "http://github.com/Rafe/mail_parser"
    gem.authors = ["Jimmy Chao"]
    gem.test_files = ["spec/*.rb"]
    gem.files = ["lib/*.rb","lib/*/*.rb"]
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install jeweler -s http://gemcutter.org"
end

desc "running specs"
task :specs do 
  system "rspec spec"
end

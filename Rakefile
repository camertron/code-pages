$:.unshift File.join(File.dirname(__FILE__), 'lib')

require 'rubygems' unless ENV['NO_RUBYGEMS']

require 'bundler'
require 'pry-byebug'
require 'rspec/core/rake_task'
require 'rubygems/package_task'
require 'code-pages'

Bundler::GemHelper.install_tasks

task default: :spec

desc 'Run specs'
RSpec::Core::RakeTask.new do |t|
  t.pattern = './spec/**/*_spec.rb'
end

task :import do
  CodePages::Importer.import(
    CodePages.manifest, File.expand_path('../resources', __FILE__)
  )
end

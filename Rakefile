#!/usr/bin/env rake
require 'bundler/gem_tasks'

task :compile do
  Dir.chdir('ext') do
    sh 'ruby extconf.rb'
    sh 'make'
  end
end

require 'rake/testtask'
Rake::TestTask.new do |t|
  t.pattern = 'test/*_spec.rb'
end

task :test => :compile
task :default => :test

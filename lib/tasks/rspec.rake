

require 'rake'
require 'ci/reporter/rake/rspec'
require 'rspec/core/rake_task'
require './spec/component_formatter'

namespace :ci do
  task :all => ['ci:setup:rspec', 'myspec']
end

puts "aaaa"
RSpec::Core::RakeTask.new(:myspec) do |t|
  Rake::Task['ci:setup:rspec'].invoke
  puts "args = #{ARGV.inspect}"
  t.pattern = Dir.glob('spec/**/*_spec.rb')
  puts "Here"
  t.rspec_opts = '--format progress'
  t.rspec_opts = '--format ComponentFormatter'
  #t.rspec_opts = '--format ci--format progress'
  #t.rspec_opts = '--format documentation'
  # t.rspec_opts << ' more options'
  #t.rcov = true
end
#task :default => :spec


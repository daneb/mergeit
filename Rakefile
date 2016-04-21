require "bundler/gem_tasks"

task :default => 'mergeit:tests'

namespace :mergeit do

  desc 'View rspec coverage'
  task :coverage do
    ENV['COVERAGE'] = 'true'
    `rspec spec`
    `open coverage/index.html`
  end

  desc 'Run tests'
  task :tests do
    sh 'cucumber'
    sh 'rspec spec/'
  end
end

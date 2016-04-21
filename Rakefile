require "bundler/gem_tasks"

task :default => 'mergeit:tests'

namespace :mergeit do
  task :tests do
    sh 'rspec spec/'
  end
end


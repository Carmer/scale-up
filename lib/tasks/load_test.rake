require 'capybara/poltergeist'

desc "Simulate load for scale-up application"
task :load_test => :environment do
  load_test = LoadTest.new.browse
  4.times.map { Thread.new { load_test } }.map(&:join)
end

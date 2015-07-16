require 'capybara/poltergeist'

desc "Simulate load for scale-up application"
task :load_test => :environment do
  4.times.map { Thread.new { LoadTest.new.test_pages } }.map(&:join)
end

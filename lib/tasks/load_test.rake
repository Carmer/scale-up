require 'capybara/poltergeist'

desc "Simulate load for scale-up application"
task :load_test => :environment do
  threads = [Thread.new { LoadTest.new.test_pages }, Thread.new { LoadTest.new.test_pages } , Thread.new { LoadTest.new.surf }, Thread.new { LoadTest.new.surf } ].map(&:join)
end

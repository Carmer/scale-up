require 'capybara/poltergeist'

desc "Simulate load for scale-up application"
task :load_test => :environment do
  4.times.map { Thread.new { browse } }.map(&:join)
end

def browse
  require "pry"; binding.pry
  session = Capybara::Session.new(:poltergeist)
  loop do
    session.visit("http://scale-it.herokuapp.com/")
    session.all("li a").sample.click
    puts "made it"
    puts session.current_path
  end
end

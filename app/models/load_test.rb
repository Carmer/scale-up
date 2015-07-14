require 'capybara/poltergeist'

class LoadTest
  attr_reader :session

  def initialize
    @session = Capybara::Session.new(:poltergeist)
  end

  def browse
    loop do
      visit_root
      log_in("sample@sample.com", "password")
      create_ticket
      past_orders
      edit_profile
      log_out
      search_events
      add_to_cart_create_account
      log_in("admin@admin.com", "password")
      admin_edit_event
      admin_delete_event
      admin_create_event
      log_out
    end
  end

  def visit_root
    session.visit("http://scale-it.herokuapp.com")
    session.click_link("Adventure")
    puts "At root"
  end

  def log_in(email, password)
    session.click_link("Login")
    session.fill_in "session[email]", with: email
    session.fill_in "session[password]", with: password
    session.click_link_or_button("Log in")
    puts "Login"
  end

  def past_orders
    session.click_link("My Hubstub")
    session.click_link("Past Orders")
    session.click_link("My Hubstub")
    session.click_link("My Listings")
    puts "Orders"
  end

  def edit_profile
    session.click_link("My Hubstub")
    session.click_link("Manage Account")
    session.click_link("Edit User Profile")
    session.fill_in "user[city]", with: "Denver"
    session.click_button("Update Account")
  end

  def create_ticket
    session.click_link("My Hubstub")
    session.click_link("List a Ticket")
    session.select  "TLC", from: "item[event_id]"
    session.fill_in "item[section]", with: "TT"
    session.fill_in "item[row]", with: "666"
    session.fill_in "item[seat]", with: "10"
    session.fill_in "item[unit_price]", with: 33
    session.select  "Electronic", from: "item[delivery_method]"
    session.click_button("List Ticket")
    puts "created ticket"
  end

  def log_out
    session.click_link("Logout")
    puts "logout"
  end

  def search_events
    session.click_link("Buy")
    session.click_link("All Tickets")
    session.click_link("All")
    session.click_link("Sports")
    session.click_link("Music")
    session.click_link("Theater")
    session.click_link("Circus")
    session.click_link("Rodeo")
    session.click_link("Rock")
    puts "events filter used"
  end

  def add_to_cart_create_account
    session.all("p.event-name a").sample.click
    session.all("tr").sample.find(:css, "input.btn").click
    puts "cart"
    session.click_link("Cart(1)")
    session.click_link("Checkout")
    session.click_link("here")

    session.fill_in "user[full_name]", with: "Andrew Carmer"
    session.fill_in "user[display_name]", with: ("A".."Z").to_a.shuffle.first(2).join
    session.fill_in "user[email]", with: (1..20).to_a.shuffle.join + "@sample.com"
    session.fill_in "user[street_1]", with: "main st"
    session.fill_in "user[city]", with: "Denver"
    session.select  "Colorado", from: "user[state]"
    session.fill_in "user[zipcode]", with: "80204"
    session.fill_in "user[password]", with: "password"
    session.fill_in "user[password_confirmation]", with: "password"
    session.click_button("Create my account!")

    session.click_link("Cart(1)")
    session.click_link_or_button("Remove")
    puts "add item to cart, create account, and remove cart item"
  end

  def admin_edit_event
    session.click_link "Users"
    session.all("tr").sample.click_link "Store"
    session.click_link "Events"
    session.click_link "Manage Events"
    session.all("tr").sample.click_link "Edit"
    session.fill_in "event[title]", with: ("A".."Z").to_a.shuffle.first(5).join
    session.fill_in "event[date]", with: 33.days.from_now.change({ hour: 5, min: 0, sec: 0  })
    session.fill_in "event[start_time]", with: "2000-01-01 19:00:00"
    session.click_button "Submit"
    puts "admin event edit"
  end

  def admin_delete_event
    session.all("tr").sample.click_link "Delete"
    puts "admin delete event"
  end

  def admin_create_event
    session.click_link "Create Event"
    session.fill_in "event[title]", with: ("A".."Z").to_a.shuffle.first(5).join
    session.fill_in "event[description]", with: "No description necessary."
    session.fill_in "event[date]", with: 33.days.from_now.change({ hour: 5, min: 0, sec: 0  })
    session.fill_in "event[start_time]", with: "2000-01-01 19:00:00"
    session.click_button "Submit"
    puts "admin create event"
  end
end

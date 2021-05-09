module LoginHelper
  def login(email, password)
    visit root_path
    fill_in :email, with: email
    fill_in :password, with: password
    click_button 'Log In'
    puts "login test"
  end
end

# RSpec.configure do |c|
  # c.include LoginHelper
# end

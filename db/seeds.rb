# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)




URL = Nokogiri::HTML(URI.open("https://1000mostcommonwords.com/1000-most-common-russian-words/"))
rows = URL.css(".entry-content > table > tbody > tr")
rows.shift
password = '1234'

users = %w[user1@mail.com user2@mail.com].map do |email|
  User.create!(email: email,
               password: password,
               password_confirmation: password
             )
end

rows.each do |e|
  card = users[1].cards.create!(original_text: e.css('td')[2].text,
                                translated_text: e.css('td')[1].text)
  random_date = Date.today + rand(-3..3)
  card.update_attribute(:review_date, random_date)
end

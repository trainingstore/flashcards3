require "rails_helper"

describe 'profile of users' do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user, email: 'user2@mail.com') }
  let!(:card) { create(:card, user: user )}
  let!(:another_card) do
    create(:card, user: another_user,
                  original_text: 'test',
                  translated_text: 'тест')
  end

  before(:each) do
    visit root_path
  end

  context 'access to cards (user)' do

    before(:each) do
      fill_in 'Email', with: user.email
      puts "user email #{user.email}"
      puts "card #{card.original_text}"
      fill_in 'Password', with: '1234'
      click_button 'Log In'
      click_link 'Все карточки'
    end

    it "has access to own cards" do
      expect(page).to have_content 'картина'
    end

    it "does not have access to another user's card" do
      expect(page).not_to have_content 'тест'
    end
  end

  context 'access to cards (another user)' do

    before(:each) do
      login(another_user.email, '1234')
      puts "user email #{another_user.email}"
      puts "card #{another_card.original_text}"
      click_link 'Все карточки'
    end

    it "has access to own cards" do
      expect(page).to have_content 'тест'
    end

    it "does not have access to user's card" do
      expect(page).not_to have_content 'картина'
    end

  end


end

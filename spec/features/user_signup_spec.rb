require 'rails_helper'

describe 'user signup' do

  let(:user) { build(:user) }

  before(:each) do
    visit '/signup'
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: '1234'
    fill_in 'user[password_confirmation]', with: '1234'
    click_button 'Submit'
  end

  it 'informs about account creation' do
    expect(page).to have_content 'Account was successfully created'
  end

  context 'after registration user is logged in' do
    it 'gives access to check translation' do
      visit root_path
      expect(page).to have_content 'no cards for review'
    end

    it 'gives access to all cards' do
      visit root_path
      click_link 'Все карточки'
      expect(page).to have_content 'original text'
      expect(page).to have_content 'translated text'
      expect(page).to have_content 'review date'
      expect(page).to have_content 'links'
    end

    it 'gives access to edit profile ' do
      click_link 'Edit Profile'
      expect(page).to have_content 'Email'
      expect(page).to have_content 'Password'
      expect(page).to have_content 'Password confirmation'
    end
  end

end

require "rails_helper"

describe 'cheking_answer' do
  let!(:user) { create(:user) }
  let!(:card) { create(:card, user: user) }

  before(:each) do
    card.update_attribute(:review_date, Date.today - 3)
    login(user.email, '1234')
  end

  context 'when visit main page' do
    it "has word for translation" do
      expect(page).to have_content card.translated_text
    end
  end

  context 'check translation' do
    it "shows true when answer is correct" do
      fill_in 'translation', with: card.original_text
      click_button 'Check'
      expect(page).to have_content 'True'
    end
    it "shows false when answer is not correct" do
      fill_in 'translation', with: 'test'
      click_button 'Check'
      expect(page).to have_content 'False'
    end
  end
end

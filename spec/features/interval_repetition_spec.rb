require 'rails_helper'

describe 'interval repetion' do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck) }
  before(:each) do
    login(user.email, '1234')
  end
  context 'checking translation of new card - right answer' do
    it 'increases review_date to 12.hours.from_now' do
      fill_in(:translation, with: 'picture')
      click_button 'Check'
      card.reload
      expect(card.review_date.to_formatted_s(:long)).to eql 12.hours.from_now.to_formatted_s(:long)
    end
  end
  context 'checking translation of card that previously reviewed - right answer' do
    it 'increases review date to 2.weeks.from_now' do
      card.update_attribute(:box, 3)
      fill_in(:translation, with: 'picture')
      click_button 'Check'
      card.reload
      expect(card.review_date.to_date).to eql 2.weeks.from_now.to_date
    end
  end
  context 'checking translation of card that previously reviewed - wrong answer' do
    it 'decreses review_date to 12.hours.from_now after 3 wrong guesses' do
      card.update_attribute(:box, 3)
      4.times do
        fill_in(:translation, with: 'wrong')
        click_button 'Check'
        card.reload
      end
      expect(card.box).to eql 1
    end
  end
  context 'checking translation of card that previously reviewed - wrong answer' do
    it 'does not change review_date after 1 wrong guess' do
      card.update_attribute(:box, 3)
      fill_in(:translation, with: 'wrong')
      click_button 'Check'
      card.reload
      expect(card.review_date.to_date).to eql Date.today
    end
  end
end

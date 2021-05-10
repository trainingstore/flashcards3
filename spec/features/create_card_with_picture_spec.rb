require "rails_helper"

describe 'creating card with picture' do
  let!(:user) { create(:user) }

  before(:each) do
    login(user.email, '1234')
    click_link 'Добавить карточку'
    fill_in('card[original_text]', with: 'test')
    fill_in('card[translated_text]', with: 'тест')
  end

  context 'uploading picture by url' do
    
    before(:each) do
      picture_url = 'https://flashcards3.s3-us-west-1.amazonaws.com/uploads/card/picture/360/cf.jpg'
      fill_in('card[remote_picture_url]', with: picture_url)
    end

    it 'gives notification' do
      click_button 'Create flashcard'
      expect(page).to have_content 'Card created'
    end

    it 'creates card' do
      expect { click_button 'Create flashcard' }.to change(Card, :count).by(1)
    end

    it 'has picture' do
      click_button 'Create flashcard'
      expect(page.find('img')['src']).to have_content 'cf.jpg'
    end

  end

  context 'uploading picture by attaching a file' do

    before(:each) do
      attach_file 'card[picture]', Rails.root + 'app/assets/images/cf.jpg'
    end

    it 'gives notification' do
      click_button 'Create flashcard'
      expect(page).to have_content 'Card created'
    end

    it 'creates card' do
      expect { click_button 'Create flashcard' }.to change(Card, :count).by(1)
    end

    it 'has picture' do
      click_button 'Create flashcard'
      expect(page.find('img')['src']).to have_content 'cf.jpg'
    end

  end

end

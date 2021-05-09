require 'rails_helper'

RSpec.describe Card, type: :model do

  subject(:card) { FactoryBot.build(:card) }

  describe '#check_translation' do
    context 'when translation is correct' do
      it "returns true" do
        expect(card.check_translation('picture')).to be true
      end
    end
    context 'when translation is not correct' do
      it "returns false" do
        expect(card.check_translation('test')).to be false
      end
    end
  end

  describe '#arrange_review_date' do
    it "arranges new review date 6 days from now" do
      card.arrange_review_date
      expect(card.review_date).to eq(Date.today + 6.days)
    end
  end

  describe '#not_the_same' do
    context 'when original_text equals translated_text' do
      let(:incorrect_card) { FactoryBot.build(:incorrect_card)}
      it "throws error" do
        expect(incorrect_card.not_the_same.type).to eq("and translated text shouldn't be equal.")
      end
    end
    context 'when original_text and translated_text different' do
      it "returns nil" do
        expect(card.not_the_same).to eq nil
      end
    end
  end

end

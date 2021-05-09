FactoryBot.define do
  factory :card do
      original_text {'picture'}
      translated_text {'картина'}
      review_date { Date.today }
      # user
  end

  factory :incorrect_card, class: 'Card' do
      original_text {'picture'}
      translated_text {'Picture'}
      review_date { Date.today }
      # user
  end

end

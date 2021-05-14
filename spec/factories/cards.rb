FactoryBot.define do
  factory :card do
      original_text {'picture'}
      translated_text {'картина'}
      review_date { Date.today }
      box {0}
      wrong_guess {0}
  end

  factory :incorrect_card, class: 'Card' do
      original_text {'picture'}
      translated_text {'Picture'}
      review_date { Date.today }
      box {0}
      wrong_guess {0}
  end

end

# FactoryBot.define do
#   sequence :email do |n|
#     "user#{n+2}@mail.com"
#   end
# end
FactoryBot.define do
  factory :user do
    # email { generate :email }
    email {'user3@mail.com'}
    password { '1234' }
    password_confirmation { password }
  end
end

FactoryGirl.define do
  factory :user do
    sequence(:email) { |t| "my_mail#{t}@example.com" }
    password 'password'
    password_confirmation 'password'

    trait :with_bad_email do
      email 'bad_email'
    end
  end

end

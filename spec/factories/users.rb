FactoryGirl.define do
  factory :user do
    email 'my_mail@example.com'
    password 'password'
    password_confirmation 'password'

    trait :with_bad_email do
      email 'bad_email'
    end
  end

end

FactoryGirl.define do
  factory :user do
    email 'my_mail@example.com'
    password 'password'
    password_confirmation 'password'
  end

end

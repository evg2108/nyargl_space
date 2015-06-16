FactoryGirl.define do
  factory :author do
    first_name 'first_name'
    about_author 'about_author'

    trait :with_last_name do
      last_name 'last_name'
    end

    trait :with_patronymic do
      patronymic 'patronymic'
    end
  end
end

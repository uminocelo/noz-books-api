# frozen_string_literal: true

FactoryBot.define do
  factory :author do
    name { Faker::Name.name }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    main_genre { ['Fiction', 'Non-fiction', 'Poetry'].sample }
  end

  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    genre { Faker::Book.genre }
    publication_date { Faker::Date.between(from: 50.years.ago, to: Date.today) }
    publisher { Faker::Book.publisher }
    author

    trait :with_author do
      author
    end

    trait :without_author do
      author { nil }
    end
  end
end

FactoryGirl.define do
  factory :spy do
    username "spy"
    image_url "spy.jpeg"
    uid "12345"
    provider "developer"
  end

  factory :mark do
    uid "1291877"
    username "jeffdesom"
    name "Jeff Desom"
    image_url "mark.jpeg"
    provider "vimeo"

    factory :mark_with_media do 
      transient do
        media_count 5
      end

      after(:create) do |mark, evaluator|
        create_list(:medium, evaluator.media_count, mark: mark)
      end
    end

    trait :prez do 
      uid "813286"
      username "BarackObama"
      provider "twitter"
    end
  end

  factory :medium do
    mark
    text "hello"
    media_url "hello.jpeg"
    date_posted "whenever"
    link "whatever"
    medium_type "twitter"
  end
end

FactoryGirl.define do
  factory :spy do 
    username "spy"
    image_url "spy.jpeg"
    uid "12345"
    provider "developer"
  end

  factory :mark do 
    uid "56789"
    username "markisthebest"
    name "mark"
    image_url "mark.jpeg"
    provider "developer"
  end

  factory :medium do
    text "hello"
    media_url "hello.jpeg"
    mark_id 1
    date_posted "whenever"
    link "whatever"
    medium_type "twitter"
  end
end
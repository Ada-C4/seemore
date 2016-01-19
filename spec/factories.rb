FactoryGirl.define do
  factory :twitter_handle, class: Handle do
    name "houglande"
    uri "https://twitter.com/sferik"
    provider "twitter"
  end

  factory :vimeo_handle, class: Handle do
    name "Johnny Kelly"
    uri "/users/253450"
    provider "vimeo"
  end

  factory :user1, class: User do
    name "daphne"
  end

  factory :user2, class: User do
    name "wakkawakka"
  end

  factory :twitter_medium, class: Medium do
    uri "link"
    embed "link"
    posted_at Time.now
    association :handle, factory: :twitter_handle
  end

  factory :vimeo_medium, class: Medium do
    uri "link"
    embed "link"
    posted_at Time.now
    association :handle, factory: :vimeo_handle
  end

  factory :identity do
    uid "1234"
    provider "twitter"
    user_id 1
  end
end

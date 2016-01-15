FactoryGirl.define do
  factory :twitter_creator, class: Creator do
    p_id 1621062337
    username "adaacademy"
    provider "twitter"
  end

  factory :vimeo_creator, class: Creator do
    p_id 9573882
    username "Sleepy Puppies"
    provider "vimeo"
  end

  factory :developer_user, class: User do
    name "Ada Lovelace"
    uid 1234
    provider "developer"
  end

  factory :user, class: User do
    name "Ada"
    uid "1234"
    provider "twitter"
  end
end

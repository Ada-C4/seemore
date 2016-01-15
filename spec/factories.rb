FactoryGirl.define do


  factory :twitter_user, class: User do
    name "George"
    uid "1ab3da5"
    provider "twitter"
    email "test@test.com"
    avatar_url "www.image.com"
  end

  factory :vimeo_user, class: User do
    name "Nancy"
    uid "1ab3da5"
    provider "vimeo"
    email "test@test.com"
    avatar_url "www.image.com"
  end

  factory :some_user, class: User do
    name "Tammy"
    uid "15"
    provider "vimeo"
    email "some@some.com"
    avatar_url "www.some.com"
  end

  factory :twitter_creator, class: Creator do
    name "Edward"
    description "HELLO!"
    profile_pic "www.profilepic.com"
    provider "twitter"
    uid "fdsfdsfs"
  end

  factory :vimeo_creator, class: Creator do
    name "Nancy"
    description "VIMEO!!"
    profile_pic "www.profilepic.com"
    provider "vimeo"
    uid "1ab3da5"
  end

 factory :twitter_user_2, class: User do
   name "Bob"
   uid "32ds1af"
   provider "twitter"
   email "test@fasd.com"
   avatar_url "www.a.com"
 end

 factory :twitter_user_3, class: User do
   name "Rob"
   uid "323523"
   provider "twitter"
   email "test2@fasd.com"
   avatar_url "www.ab.com"
 end

 factory :twitter_user_not_following, class: User do
   name "Roy"
   uid "323443"
   provider "twitter"
   email "test@fasd.com"
   avatar_url "www.fake.com"
 end

 factory :twitter_user_unfollowing, class: User do
   name "Grob"
   uid "323578"
   provider "twitter"
   email "test2@test.com"
   avatar_url "www.fake.com"
 end

 factory :twitter_creator_2, class: Creator do
   name "Eddie"
   description "Hola!"
   profile_pic "www.profilepix.com"
   provider "twitter"
   uid "fdsfdas"
 end

 factory :twitter_creator_to_unfollow, class: Creator do
   name "Nancy"
   description "Hi!"
   profile_pic "www.profilepix.com"
   provider "twitter"
   uid "112233"
 end

 # video factories
 factory :video do
   posted_at "2013-07-19T01:31:12+00:00"
   uri "/user/video"
   name "The Best Video"
   embed "www.embed.com"
   description "I am a video"
   vimeo_id "32515"
   association :creator, factory: :vimeo_creator
 end

 factory :tweet do
   posted_at "2016-01-14 09:15:55 +0000"
   uid "687563783829635072"
   association :creator, factory: :twitter_creator
 end

 # category factories
 factory :category do
   association :creator, factory: :twitter_creator
   association :user, factory: :twitter_user
 end

 factory :category_2, class: Category do
   association :creator, factory: :twitter_creator_2
   association :user, factory: :twitter_user_3
 end

 factory :unfollow_category, class: Category do
   association :creator, factory: :twitter_creator_to_unfollow
   association :user, factory: :twitter_user_unfollowing
 end
end

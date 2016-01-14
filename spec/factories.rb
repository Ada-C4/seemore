FactoryGirl.define do

  factory :user do
    uid "1234"
    provider "developer"
    name "Test"
  end

  factory :vimeo_user do
      uri  "/users/1111111"
      name "audrey"
      description "I love licorice"
      location "Seattle, WA"
      videos_uri "/users/1111111/videos"
      profile_images_uri "/users/1111111/pictures"
  end

  factory :twitter_user do
      twitter_id   "12345678"
      screen_name "kdefliese"
      name "Katherine Defliese"
      description "I really like cats"
      location "Seattle, WA"
      uri "https://twitter.com/kdefliese"
      profile_image_uri "http://pbs.twimg.com/profile_images/672319002706706432/_MQlTm-A_normal.jpg"
  end

  factory :tweet do
    twitter_id "12345678"
    text "This is a tweet"
    uri "https://twitter.com/kdefliese/status/684970660116873216"
    provider_created_at "Mon, 21 Dec 2015 17:13:59 +0000"
    embed "<blockquote class=\"twitter-tweet\"><p lang=\"en\" dir=\"ltr\"><a href=\"https://twitter.com/Elia_MG\">@Elia_MG</a> Can you share with me the link to your capstone project?</p>&mdash; Rebecca Tolmach (@BeccaTmac) <a href=\"https://twitter.com/BeccaTmac/status/678986784529870848\">December 21, 2015</a></blockquote>\n<script async src=\"//platform.twitter.com/widgets.js\" charset=\"utf-8\"></script>"
  end


  factory :video do
      title "Cool video"
      uri "/videos/102805992"
      provider_created_at "Mon, 21 Dec 2015 17:13:59 +0000"
      embed "<iframe src=\"https://player.vimeo.com/video/150661465?badge=0&autopause=0&player_id=0\" width=\"1920\" height=\"1080\" frameborder=\"0\" title=\"006 Teapot\" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>"
      association :vimeo_user
  end
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sample_subscribers = [
  { username: "Schwarzenegger", uid: "12044602" , provider: "twitter", avatar_url: "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg" }
]


client =  Seemore::Application.config.twitter
sample_stories = client.user_timeline("Schwarzenegger")
sample_stories.each do |story|
  new_story = Story.new
  new_story.uid = story.id
  new_story.text = story.text
  new_story.subscription_id = 1
  new_story.post_time = story.created_at
  new_story.save
end


#sample_stories = twitterClient.user_timeline("Schwarzenegger")

sample_subscribers.each do |subscriber|
  Subscription.create(subscriber)
end

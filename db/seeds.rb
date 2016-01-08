# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

sample_subscribers = [
  { username: "Schwarzenegger", uid: "12044602" , provider: "twitter", avatar_url: "https://pbs.twimg.com/profile_images/665340796510466048/-nsoU1Q5.jpg" },
  { username: "Schwarzenegger", uid: "15397797" , provider: "vimeo", avatar_url: "https://i.vimeocdn.com/portrait/8242122_300x300.webp" },

]

sample_subscribers.each do |subscriber|
  Subscription.create(subscriber)
end


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

user_id = "15397797"
api_url = "https://api.vimeo.com/users/#{user_id}/videos"
auth = "Bearer #{ENV["VIMEO_ACCESS_TOKEN"]}"   # use your access token
r = HTTParty.get(api_url, headers: { "Authorization" => auth, "Accept" => "application/json" })  # make sure to use the proper Accept header as recommended in the API docs
sample_videos = JSON.parse(r)["data"]

sample_videos.each do |video|
  binding.pry
  new_story = Story.new
  a = video["uri"]
  a.slice!"/videos/"
  new_story.uid = a
  new_story.url = video["link"]
  new_story.subscription_id = 1
  new_story.post_time = video["created_time"]
  new_story.save
end

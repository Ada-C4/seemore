class Story < ActiveRecord::Base
  belongs_to :subscription

  def self.find_or_create(uid, text, url = nil, media_content = nil, subscription_id, post_time)
    story = self.find_by(uid: uid)
    if !story.nil?
      return story
    else
      story = Story.new
      story.uid = uid
      story.text = text
      story.url = url
      story.media_content = media_content
      story.subscription_id = subscription_id
      story.post_time = post_time
      if story.save
        return story
      else
        return nil
      end
    end
  end
end

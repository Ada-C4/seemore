class Story < ActiveRecord::Base
  belongs_to :subscription

  def self.find_or_create(uid, text, subscription_id, post_time)
    story = self.find_by(uid: uid)

    if !story.nil?
      binding.pry
      return story
    else
      story = Story.new
      story.uid = uid
      story.text = text
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

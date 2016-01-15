
class Mark < ActiveRecord::Base
  has_and_belongs_to_many :spies
  has_many :media

  validates :username, :provider, :uid, presence: true
  validates :uid, uniqueness: true

  def self.vimeo_lookup(search_term)
    auth = "Bearer #{ENV['VIMEO_ACCESS_TOKEN']}"
    marks = HTTParty.get("https://api.vimeo.com/users", query: {:query => search_term}, headers: { "Authorization" => auth })
    parsed_marks = JSON.parse(marks)
    marks_data = parsed_marks["data"]
    result = []
    marks_data.each do |mark|
      unless mark["pictures"].nil?
        image = mark["pictures"]["sizes"].last
      end

      if image.nil?
        profile_image = "blank.png"
      else
        profile_image = image["link"]
      end

      uid = mark["uri"].gsub(/[^\d]/, '')
      username = mark["link"].split('/')[-1]

      result <<  Mark.new(
        username: username,
        name: mark["name"],
        bio: mark["bio"],
        location: mark["location"],
        link: mark["link"],
        image_url: profile_image,
        uid: uid,
        provider: "vimeo"
        )
    end
    return result
  end

  def self.single_mark_vimeo_lookup(search_term)
    auth = "Bearer #{ENV['VIMEO_ACCESS_TOKEN']}"
    mark = HTTParty.get("https://api.vimeo.com/users/#{search_term}/", headers: { "Authorization" => auth })
    mark_parsed = JSON.parse(mark)

    if !mark_parsed["error"].nil?
      return mark_parsed["error"]
    else
      unless mark_parsed["pictures"].nil?
        image = mark_parsed["pictures"]["sizes"].last
      end

      if image.nil?
        profile_image = "blank.png"
      else
        profile_image = image["link"]
      end

      uid = mark_parsed["uri"].gsub(/[^\d]/, '')

      result =  Mark.new(
        username: search_term,
        name: mark_parsed["name"],
        bio: mark_parsed["bio"],
        location: mark_parsed["location"],
        link: mark_parsed["link"],
        image_url: profile_image,
        uid: uid,
        provider: "vimeo"
        )
    end
    return result
  end

  def twitter
    Seemore::Application.config.twitter
  end

  def refresh
    if self.provider == "twitter"
      @tweets = twitter.user_timeline(self.username, count: 20)
      @tweets.each do |tweet|
        if Medium.find_by(uid: tweet.id).nil?
          Medium.create(
            mark_id: self.id,
            date_posted: tweet.created_at,
            link: tweet.source,
            text: tweet.text,
            medium_type: "twitter",
            uid: tweet.id,
            retweeted_from: tweet.retweeted_status.user.screen_name,
            retweeted_from_link: tweet.retweeted_status.user.url
            )
        end
      end
    elsif self.provider == "vimeo"
      Medium.video_lookup(self.username)
    end
  end
end

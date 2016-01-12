class Medium < ActiveRecord::Base
  belongs_to :mark

  validates :mark_id, :date_posted, :link, :medium_type, presence: true

  def self.video_lookup(username)
    mark = Mark.find_by(username: username)
    auth = "Bearer #{ENV['VIMEO_ACCESS_TOKEN']}"

    media = HTTParty.get("https://api.vimeo.com/users/#{username}/videos", query: {"page" => 1, "per_page" => 10}, headers: { "Authorization" => auth })

    parsed_media = JSON.parse(media)
    data = parsed_media["data"]

    data.each do |d|
      if Medium.find_by(link: d["link"]).nil?
        Medium.create(
          mark_id: mark.id,
          media_url: d["link"],
          date_posted: d["created_time"],
          link: d["link"],
          text: d["description"],
          title: d["name"],
          medium_type: "vimeo", 
          uid: d["link"].split('/')[-1],
          )
      end
    end
  end

end

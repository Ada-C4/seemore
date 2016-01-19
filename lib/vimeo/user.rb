module Vimeo
  class User < Base
    attr_reader :uri, :name, :link
    attr_accessor :subscribed, :profile_image_uri

    def initialize(user_hash)
      @uri = user_hash["uri"]
      @name = user_hash["name"]
      @link = user_hash["link"]
      @profile_image_uri = nil
      @subscribed = false
    end

    def self.find_by_uri(handle_uri)
      response = HTTParty.get("#{BASE_URI}#{handle_uri}", headers: HEADERS)
      parsed_response = JSON.parse(response)

      new_user = self.new(parsed_response)
      new_user.profile_image_uri = parsed_response["pictures"]["sizes"].last["link"] unless parsed_response["pictures"].nil?

      return new_user
    end

    def self.find_by_name(user_name, page=1)
      query = { query: user_name, page: page, fields: "uri,name,link,pictures" }

      response = HTTParty.get("#{BASE_URI}/users", query: query, headers: HEADERS)
      parsed_response = JSON.parse(response)

      user_object_array = Array.new
      parsed_response["data"].each do |hash|
        new_user = self.new(hash)
        new_user.profile_image_uri = hash["pictures"]["sizes"].last["link"] unless hash["pictures"].nil?
        user_object_array << new_user
      end

      return user_object_array
    end

  end
end

class Instagramr
  include HTTParty
  attr_accessor :token, :access_token

  def feed_root
    "https://api.instagram.com/v1/users/self/media/recent/"
  end

  def initialize(access_token)
    @access_token = access_token
  end

  def feed(url)
    the_url = "#{url}?access_token=#{self.access_token}"
    self.class.get(the_url)
  end

  def profile_picture
    url = "https://api.instagram.com/v1/users/self/?access_token=#{self.token}"
    response = Hashie::Mash.new(HTTParty.get(url))
    response["data"]["profile_picture"]
  end

  def profile
    url = "https://api.instagram.com/v1/users/self/?access_token=${{INSTAGRAM_API_ACCESS_TOKEN}}"
    response = HTTParty.get(url).parsed_response['data']
    response["instagram_id"] = response.delete('id')
    response.delete('bio')
    response
  end

end

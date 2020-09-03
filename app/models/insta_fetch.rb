require 'resque/plugins/heroku'

class InstaFetch
  @queue = :fetch
  extend Resque::Plugins::Heroku

  def self.perform(user_id,filename,url)
    user = User.find(user_id)
    db_client = Dropbox::API::Client.new(token: user.dropbox_access_token, secret: user.dropbox_secret_token)
    puts "getting #{url}"
    db_client.upload(filename,Net::HTTP.get(URI.parse(url)))
  end
end
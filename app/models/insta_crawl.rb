require 'resque/plugins/heroku'

class InstaCrawl
  @queue = :crawl
  extend Resque::Plugins::Heroku

  def self.perform(user_id)
    user = User.find(user_id)
    ig = Instagramr.new(user.instagram_access_token)
    db_client = Dropbox::API::Client.new(token: user.dropbox_access_token, secret: user.dropbox_secret_token)
    next_url = ig.feed_root
    pcnt = 0
    while next_url do
      pcnt = pcnt + 1
      puts "Page #{pcnt}"
      page = ig.feed(next_url)
      next_url = page["pagination"]["next_url"]
      page["data"].each do |picture|
        url = picture["images"]["standard_resolution"]["url"]
        filename = url.split('/').last
        puts "\t\tgetting: #{filename}: #{url}"

        db_exists = db_client.search(filename)
        begin
          if db_exists.blank?
            #  queue get picture
            Resque.enqueue(InstaFetch, user.id, filename, url)
          else
            puts "already got it"
          end
        rescue Exception => e
          puts e.message
          redo if e.message.include?('reset')
        end
      end
    end
    # send email
    CrawlerMailer.crawl_complete_email(user).deliver
  end
end
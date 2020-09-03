class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :instagram_id, :instagram_access_token, :username, :full_name, :profile_picture, :email
  validates_email_format_of :email, :allow_blank => true
  after_save :queue_crawl

  private
  
  def queue_crawl
    if self.instagram_id.present? &&
        self.instagram_access_token.present? &&
        self.dropbox_access_token.present? &&
        self.dropbox_secret_token.present? &&
        self.email.present? &&
        self.has_migrated == false
      Resque.enqueue(InstaCrawl, self.id)
    end
  end
end

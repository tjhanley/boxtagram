class Crawler < ActionMailer::Base
  default from: "no-reply@#{Settings.app_name}.com"

  def crawl_complete_email(user)
    puts "email sent..."
    @user = user
    mail(:to => @user.email,
      :subject => "#{Settings.app_name} has sent you a message")
  end

end

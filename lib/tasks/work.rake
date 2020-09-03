namespace :work do
  desc "Do It"
  task :migrate => :environment do
    User.find_in_batches(conditions: {has_migrated: false}) do |group|
      puts "group: #{group.count}"
      group.each do |user|
        puts "\t#{user.full_name}: "
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
            pic_url = picture["images"]["standard_resolution"]["url"]
            f_name = pic_url.split('/').last
            puts "\t\tgetting: #{f_name}: #{pic_url}"

            db_exists = db_client.search(f_name)
            begin
              if db_exists.blank?
                db_client.upload(f_name,Net::HTTP.get(URI.parse(pic_url)))
              else
                puts "already got it"
              end
            rescue Exception => e
              puts e.message
              redo if e.message.include?('reset')
            end
          end
        end
        user.has_migrated = true
        user.save
      end
    end
  end
end
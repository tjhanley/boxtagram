class StaticController < ApplicationController
  def home
    @instagram = Instagramr.new(session[:instagram_access_token])
    if session[:dropbox_access_token] && session[:dropbox_secret_token]
      @db_client = Dropbox::API::Client.new(token: session[:dropbox_access_token], secret: session[:dropbox_secret_token])
    end
    @user = User.find_by_instagram_id(session[:instagram_id])
  end
end

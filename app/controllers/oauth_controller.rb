class OauthController < ApplicationController

  def connect_to_instagram
    redirect_to Instagram.authorize_url(:redirect_uri => Settings.instagram.callback)
  end

  def instagram
    response = Instagram.get_access_token(params[:code], :redirect_uri => Settings.instagram.callback)
    session[:instagram_access_token] = response.access_token
    instagramr = Instagramr.new(session[:instagram_access_token])
    profile = instagramr.profile
    session[:instagram_id] = profile["instagram_id"]

    u = User.find_or_create_by_instagram_id(instagram_id: profile["instagram_id"].to_i,
        username: profile["username"], 
        full_name: profile["full_name"], profile_picture: profile["profile_picture"])

    u.instagram_access_token = session[:instagram_access_token]
    u.dropbox_access_token = session[:dropbox_access_token] if session[:dropbox_access_token].present?
    u.dropbox_secret_token = session[:dropbox_secret_token] if session[:dropbox_secret_token].present?
    u.save
    redirect_to root_url
  end

  def connect_to_dropbox
    consumer = Dropbox::API::OAuth.consumer(:authorize)
    session[:dropbox_request_token] = consumer.get_request_token
    redirect_to session[:dropbox_request_token].authorize_url(oauth_callback: Settings.dropbox.callback)
  end

  def dropbox
    res = session[:dropbox_request_token].get_access_token(oauth_verifier: params[:oauth_token])

    # client = Dropbox::API::Client.new token: res.token, secret: res.secret
    session[:dropbox_access_token] = res.token
    session[:dropbox_secret_token] = res.secret

    redirect_to root_url
  end
end

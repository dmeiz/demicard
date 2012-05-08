class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    @user = User.where(omniauth_provider: auth_hash['provider'], omniauth_uid: auth_hash['uid']).first_or_create
    session[:current_user] = @user
  end
end

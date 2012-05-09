class SessionsController < ApplicationController
  def create
    auth_hash = request.env['omniauth.auth']
    user = User.where(omniauth_provider: auth_hash['provider'], omniauth_uid: auth_hash['uid']).first_or_create
    session[:user_id] = user.id
    redirect_to cards_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end

class WelcomeController < ApplicationController
  def index
    render :text => "Welcome to Demicard!"
  end

  def authenticated
    render :text => "<pre>#{request.env['omniauth.auth'].inspect}</pre>"
  end
end

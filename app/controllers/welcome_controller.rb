class WelcomeController < ApplicationController
  def index
  end

  def authenticated
    render :text => "<pre>#{request.env['omniauth.auth'].inspect}</pre>"
  end
end

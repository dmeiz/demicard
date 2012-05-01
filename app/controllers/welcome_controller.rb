class WelcomeController < ApplicationController
  def index
    render :text => "Welcome to Demicard"
  end
end

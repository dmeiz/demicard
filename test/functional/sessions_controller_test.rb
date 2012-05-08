require 'test_helper'

class SessionsControllerTest < ControllerSpec
  before do
    @controller = SessionsController.new
  end

  describe '#create' do
    before do
      @auth_hash =  {
        'uid' => '1234',
        'provider' => 'twitter'
      }

      @request.env['omniauth.auth'] = @auth_hash
    end

    it 'should create a new user' do
      get :create

      assert_response :success

      user = User.find_by_omniauth_provider_and_omniauth_uid(@auth_hash['provider'], @auth_hash['uid'])
      user.wont_be_nil

      session[:current_user].must_equal user
    end

    it 'should find an existing user' do
      @user = User.create(:pr)
      get :create

      assert_response :success

      user = User.find_by_omniauth_provider_and_omniauth_uid(@auth_hash['provider'], @auth_hash['uid'])
      user.wont_be_nil

      session[:current_user].must_equal user
    end
  end
end

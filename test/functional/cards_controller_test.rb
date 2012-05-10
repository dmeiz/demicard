require 'test_helper'

class CardsControllerTest < ControllerSpec
  before do
    @controller = CardsController.new
  end

  describe 'require_user' do
    it 'should redirect to root_path if no user is logged in' do
      get :index

      assert_redirected_to root_path
    end

    it 'should not redirect if user is logged in' do
      user = FactoryGirl.create(:user)
      session[:user_id] = user.id

      get :index

      assert_response :success
    end
  end
end

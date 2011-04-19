require 'test_helper'

class SetupControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end

require 'test_helper'

class PaperControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end

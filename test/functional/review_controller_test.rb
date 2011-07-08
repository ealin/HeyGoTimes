require 'test_helper'

class ReviewControllerTest < ActionController::TestCase
  test "should get tw" do
    get :tw
    assert_response :success
  end

end

require 'test_helper'

class ApiControllerTest < ActionController::TestCase
  test "should get new_news" do
    get :new_news
    assert_response :success
  end

end

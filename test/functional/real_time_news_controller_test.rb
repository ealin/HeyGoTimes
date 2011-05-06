require 'test_helper'

class RealTimeNewsControllerTest < ActionController::TestCase
  setup do
    @real_time_news = real_time_news(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:real_time_news)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create real_time_news" do
    assert_difference('RealTimeNews.count') do
      post :create, :real_time_news => @real_time_news.attributes
    end

    assert_redirected_to real_time_news_path(assigns(:real_time_news))
  end

  test "should show real_time_news" do
    get :show, :id => @real_time_news.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @real_time_news.to_param
    assert_response :success
  end

  test "should update real_time_news" do
    put :update, :id => @real_time_news.to_param, :real_time_news => @real_time_news.attributes
    assert_redirected_to real_time_news_path(assigns(:real_time_news))
  end

  test "should destroy real_time_news" do
    assert_difference('RealTimeNews.count', -1) do
      delete :destroy, :id => @real_time_news.to_param
    end

    assert_redirected_to real_time_news_index_path
  end
end

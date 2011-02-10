require 'test_helper'

class MircopostsControllerTest < ActionController::TestCase
  setup do
    @mircopost = mircoposts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mircoposts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mircopost" do
    assert_difference('Mircopost.count') do
      post :create, :mircopost => @mircopost.attributes
    end

    assert_redirected_to mircopost_path(assigns(:mircopost))
  end

  test "should show mircopost" do
    get :show, :id => @mircopost.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @mircopost.to_param
    assert_response :success
  end

  test "should update mircopost" do
    put :update, :id => @mircopost.to_param, :mircopost => @mircopost.attributes
    assert_redirected_to mircopost_path(assigns(:mircopost))
  end

  test "should destroy mircopost" do
    assert_difference('Mircopost.count', -1) do
      delete :destroy, :id => @mircopost.to_param
    end

    assert_redirected_to mircoposts_path
  end
end

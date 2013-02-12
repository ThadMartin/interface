require 'test_helper'

class CurrentpicksControllerTest < ActionController::TestCase
  setup do
    @currentpick = currentpicks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:currentpicks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create currentpick" do
    assert_difference('Currentpick.count') do
      post :create, currentpick: { fileselected: @currentpick.fileselected, proplemselected: @currentpick.proplemselected }
    end

    assert_redirected_to currentpick_path(assigns(:currentpick))
  end

  test "should show currentpick" do
    get :show, id: @currentpick
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @currentpick
    assert_response :success
  end

  test "should update currentpick" do
    put :update, id: @currentpick, currentpick: { fileselected: @currentpick.fileselected, proplemselected: @currentpick.proplemselected }
    assert_redirected_to currentpick_path(assigns(:currentpick))
  end

  test "should destroy currentpick" do
    assert_difference('Currentpick.count', -1) do
      delete :destroy, id: @currentpick
    end

    assert_redirected_to currentpicks_path
  end
end

require 'test_helper'

class AcceptsControllerTest < ActionController::TestCase
  setup do
    @accept = accepts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accepts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create accept" do
    assert_difference('Accept.count') do
      post :create, accept: { terms_and_condition_id: @accept.terms_and_condition_id, user_id: @accept.user_id }
    end

    assert_redirected_to accept_path(assigns(:accept))
  end

  test "should show accept" do
    get :show, id: @accept
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @accept
    assert_response :success
  end

  test "should update accept" do
    patch :update, id: @accept, accept: { terms_and_condition_id: @accept.terms_and_condition_id, user_id: @accept.user_id }
    assert_redirected_to accept_path(assigns(:accept))
  end

  test "should destroy accept" do
    assert_difference('Accept.count', -1) do
      delete :destroy, id: @accept
    end

    assert_redirected_to accepts_path
  end
end

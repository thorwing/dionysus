require 'test_helper'

class AlcoholsControllerTest < ActionController::TestCase
  setup do
    @alcohol = alcohols(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:alcohols)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create alcohol" do
    assert_difference('Alcohol.count') do
      post :create, alcohol: @alcohol.attributes
    end

    assert_redirected_to alcohol_path(assigns(:alcohol))
  end

  test "should show alcohol" do
    get :show, id: @alcohol
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @alcohol
    assert_response :success
  end

  test "should update alcohol" do
    put :update, id: @alcohol, alcohol: @alcohol.attributes
    assert_redirected_to alcohol_path(assigns(:alcohol))
  end

  test "should destroy alcohol" do
    assert_difference('Alcohol.count', -1) do
      delete :destroy, id: @alcohol
    end

    assert_redirected_to alcohols_path
  end
end

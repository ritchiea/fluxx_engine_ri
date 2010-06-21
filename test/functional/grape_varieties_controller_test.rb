require 'test_helper'

class GrapeVarietiesControllerTest < ActionController::TestCase
  setup do
    @grape_variety = grape_varieties(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:grape_varieties)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create grape_variety" do
    assert_difference('GrapeVariety.count') do
      post :create, :grape_variety => @grape_variety.attributes
    end
  end

  test "should show grape_variety" do
    get :show, :id => @grape_variety.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @grape_variety.to_param
    assert_response :success
  end

  test "should update grape_variety" do
    put :update, :id => @grape_variety.to_param, :grape_variety => @grape_variety.attributes
  end

  test "should destroy grape_variety" do
    assert_difference('GrapeVariety.count', -1) do
      delete :destroy, :id => @grape_variety.to_param
    end
  end
end

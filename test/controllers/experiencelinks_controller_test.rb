require 'test_helper'

class ExperiencelinksControllerTest < ActionController::TestCase
  setup do
    @experiencelink = experiencelinks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:experiencelinks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create experiencelink" do
    assert_difference('Experiencelink.count') do
      post :create, experiencelink: {  }
    end

    assert_redirected_to experiencelink_path(assigns(:experiencelink))
  end

  test "should show experiencelink" do
    get :show, id: @experiencelink
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @experiencelink
    assert_response :success
  end

  test "should update experiencelink" do
    patch :update, id: @experiencelink, experiencelink: {  }
    assert_redirected_to experiencelink_path(assigns(:experiencelink))
  end

  test "should destroy experiencelink" do
    assert_difference('Experiencelink.count', -1) do
      delete :destroy, id: @experiencelink
    end

    assert_redirected_to experiencelinks_path
  end
end

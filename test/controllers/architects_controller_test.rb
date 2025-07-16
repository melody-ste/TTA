require "test_helper"

class ArchitectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @architect = architects(:one)
  end

  test "should get index" do
    get architects_url
    assert_response :success
  end

  test "should get new" do
    get new_architect_url
    assert_response :success
  end

  test "should create architect" do
    assert_difference("Architect.count") do
      post architects_url, params: { architect: {} }
    end

    assert_redirected_to architect_url(Architect.last)
  end

  test "should show architect" do
    get architect_url(@architect)
    assert_response :success
  end

  test "should get edit" do
    get edit_architect_url(@architect)
    assert_response :success
  end

  test "should update architect" do
    patch architect_url(@architect), params: { architect: {} }
    assert_redirected_to architect_url(@architect)
  end

  test "should destroy architect" do
    assert_difference("Architect.count", -1) do
      delete architect_url(@architect)
    end

    assert_redirected_to architects_url
  end
end

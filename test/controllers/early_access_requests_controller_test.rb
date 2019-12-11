require 'test_helper'

class EarlyAccessRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @early_access_request = early_access_requests(:one)
  end

  test "should get index" do
    get early_access_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_early_access_request_url
    assert_response :success
  end

  test "should create early_access_request" do
    assert_difference('EarlyAccessRequest.count') do
      post early_access_requests_url, params: { early_access_request: { email: @early_access_request.email } }
    end

    assert_redirected_to early_access_request_url(EarlyAccessRequest.last)
  end

  test "should show early_access_request" do
    get early_access_request_url(@early_access_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_early_access_request_url(@early_access_request)
    assert_response :success
  end

  test "should update early_access_request" do
    patch early_access_request_url(@early_access_request), params: { early_access_request: { email: @early_access_request.email } }
    assert_redirected_to early_access_request_url(@early_access_request)
  end

  test "should destroy early_access_request" do
    assert_difference('EarlyAccessRequest.count', -1) do
      delete early_access_request_url(@early_access_request)
    end

    assert_redirected_to early_access_requests_url
  end
end

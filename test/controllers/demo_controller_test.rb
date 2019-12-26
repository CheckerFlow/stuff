require 'test_helper'

class DemoControllerTest < ActionDispatch::IntegrationTest
  test "should get demo" do
    get demo_demo_url
    assert_response :success
  end

end

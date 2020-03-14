require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get singup" do
    get sessions_singup_url
    assert_response :success
  end

end

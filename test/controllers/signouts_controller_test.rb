require 'test_helper'

class SignoutsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get signouts_index_url
    assert_response :success
  end

end

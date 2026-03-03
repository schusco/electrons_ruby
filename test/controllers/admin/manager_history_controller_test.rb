require "test_helper"

class Admin::ManagerHistoryControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get admin_manager_history_new_url
    assert_response :success
  end

  test "should get show" do
    get admin_manager_history_show_url
    assert_response :success
  end
end

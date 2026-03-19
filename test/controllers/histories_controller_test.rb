require "test_helper"

class HistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @controller.define_singleton_method(:authenticate_admin!) { true }
  end

  test "should get index" do
    get history_index_url
    assert_response :success
  end
end

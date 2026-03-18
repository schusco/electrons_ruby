require "test_helper"

class Admin::ManagerHistoryControllerTest < ActionDispatch::IntegrationTest
  setup do
    @history = histories(:three)
  end
  test "should get new" do
    get new_manager_history_url
    assert_response :success
  end

  test "should get show" do
    get results_history_url(@history)
    assert_response :success
  end

  test "should create history" do
    assert_difference("History.count") do
      post results_histories_url(@history), params: { results_history: { Data: @history.Data, Finish: @history.Finish, YearEnd: @history.YearEnd, YearStart: 2026 } }
    end

    assert_redirected_to history_index_url
  end

  test "should get edit" do
    get edit_history_url(@history)
    assert_response :success
  end

  test "should update history" do
    patch history_url(@history), params: { history: { Category: @history.Category, Data: @history.Data, Finish: @history.Finish, YearEnd: @history.YearEnd, YearStart: @history.YearStart } }
    assert_redirected_to history_index_url
  end

  test "should destroy history" do
    assert_difference("History.count", -1) do
      delete history_url(@history)
    end

    assert_redirected_to history_index_url
  end
end

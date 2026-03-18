require "test_helper"

class AwardsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @award = awards(:one)
    @player = players(:one)
  end

  test "should get index" do
    get player_awards_url(@player), params: { admin_token: "test_token_123" }
    assert_response :success
  end

  test "should get new" do
    get new_player_award_url(@player), params: { admin_token: "test_token_123" }
    assert_response :success
  end

  test "should create award" do
    assert_difference("Award.count") do
      post player_awards_url(@award.Player_id), params: { admin_token: "test_token_123", award: { award: @award.award, Player_id: @award.Player_id } }
    end

    assert_redirected_to player_url(@award.Player_id)
  end

  test "should show award" do
    get award_url(@award)
    assert_response :success
  end

  test "should get edit" do
    get edit_award_url(@award)
    assert_response :success
  end

  test "should update award" do
    patch award_url(@award), params: { award: { admin_token: "test_token_123", award: @award.award, Player_id: @award.Player_id } }
    assert_redirected_to award_url(@award)
  end

  test "should destroy award" do
    assert_difference("Award.count", -1) do
      delete award_url(@award)
    end

    assert_redirected_to player_awards_url(@award.player)
  end
end

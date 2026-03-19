require "test_helper"

class GameschedulesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gameschedule = gameschedules(:one)
  end

  test "should get index" do
    get gameschedules_url
    assert_response :success
  end

  test "should get new" do
    get new_gameschedule_url
    assert_response :success
  end

  test "should create gameschedule" do
    assert_difference("Gameschedule.count") do
      post gameschedules_url, params: { gameschedule: { Game_Date: @gameschedule.Game_Date, Location: @gameschedule.Location,
        LocationId: @gameschedule.LocationId, opponent: @gameschedule.Opponent, Manager: 1 } }
    end

    assert_redirected_to gameschedule_url(Gameschedule.last)
  end

  test "should show gameschedule" do
    get gameschedule_url(@gameschedule)
    assert_response :success
  end

  test "should get edit" do
    get edit_gameschedule_url(@gameschedule)
    assert_response :success
  end

  test "should update gameschedule" do
    patch gameschedule_url(@gameschedule), params: { gameschedule: { Game_Date: @gameschedule.Game_Date, Location: "Winnemac Park", LocationId: 1, Opponent: "Hounds" } }
    assert_redirected_to gameschedule_url(@gameschedule)
  end
end

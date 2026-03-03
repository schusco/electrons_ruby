require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @player = players(:one)
  end

  test "should get index" do
    get players_url
    assert_response :success
  end

  test "should get new" do
    get new_player_url
    assert_response :success
  end

  test "should create player" do
    assert_difference("Player.count") do
      post players_url, params: { player: { Bats: @player.Bats, Current: @player.Current, DOB: @player.DOB, Divorces: @player.Divorces, First_Name: @player.First_Name, Height: @player.Height, Hometown: @player.Hometown, Image: @player.Image, Last_Name: @player.Last_Name, Nickname: @player.Nickname, POS1: @player.POS1, POS2: @player.POS2, POS3: @player.POS3, Player_ID: @player.Player_ID, Throws: @player.Throws, Weight: @player.Weight, email: @player.email, uniform: @player.uniform } }
    end

    assert_redirected_to player_url(Player.last)
  end

  test "should show player" do
    get player_url(@player)
    assert_response :success
  end

  test "should get edit" do
    get edit_player_url(@player)
    assert_response :success
  end

  test "should update player" do
    patch player_url(@player), params: { player: { Bats: @player.Bats, Current: @player.Current, DOB: @player.DOB, Divorces: @player.Divorces, First_Name: @player.First_Name, Height: @player.Height, Hometown: @player.Hometown, Image: @player.Image, Last_Name: @player.Last_Name, Nickname: @player.Nickname, POS1: @player.POS1, POS2: @player.POS2, POS3: @player.POS3, Player_ID: @player.Player_ID, Throws: @player.Throws, Weight: @player.Weight, email: @player.email, uniform: @player.uniform } }
    assert_redirected_to player_url(@player)
  end

  test "should destroy player" do
    assert_difference("Player.count", -1) do
      delete player_url(@player)
    end

    assert_redirected_to players_url
  end
end

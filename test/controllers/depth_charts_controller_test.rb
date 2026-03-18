require "test_helper"

class DepthChartsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @depth_chart = depth_charts(:one)
  end

  test "should get index" do
    get depth_charts_url
    assert_response :success
  end

  test "should get new" do
    get new_depth_chart_url
    assert_response :success
  end

  test "should create depth_chart" do
    assert_difference("DepthChart.count") do
      post depth_charts_url, params: { depth_chart: { Player: 1, Position: 1, Rank: 3 } }
    end

    assert_redirected_to depth_chart_url(DepthChart.last)
  end

  test "should show depth_chart" do
    get depth_chart_url(@depth_chart)
    assert_response :success
  end

  test "should get edit" do
    get edit_position_depth_charts_url(1, @depth_chart)
    assert_response :success
  end

  test "should update depth_chart" do
    patch update_position_depth_charts_url(position: @depth_chart.Position), params: {
      depth_charts: {
        @depth_chart.id => {
           Player: 1,
           Rank: 4 }
          }
        }
    assert_redirected_to depth_charts_url
  end

  test "should destroy depth_chart" do
    assert_difference("DepthChart.count", -1) do
      delete depth_chart_url(@depth_chart)
    end

    assert_redirected_to depth_charts_url
  end
end

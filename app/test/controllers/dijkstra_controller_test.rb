require 'test_helper'

class DijkstraControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dijkstra_index_url
    assert_response :success
  end

end

require 'test_helper'

class HeapsortControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get heapsort_index_url
    assert_response :success
  end

end

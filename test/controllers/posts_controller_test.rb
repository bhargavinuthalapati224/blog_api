require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @post = posts(:one) # This assumes you have a fixture or factory set up for a post
  end

  test "should get index" do
    get posts_url, as: :json
    assert_response :success
  end
end

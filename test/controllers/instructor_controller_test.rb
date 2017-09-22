require 'test_helper'

class InstructorControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get instructor_index_url
    assert_response :success
  end

end

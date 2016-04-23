require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full title helper" do
    assert_equal full_title,         "The Social App"
    assert_equal full_title("Help"), "Help | The Social App"
  end
end
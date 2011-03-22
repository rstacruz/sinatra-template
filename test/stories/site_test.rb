require File.expand_path("../../story_helper", __FILE__)

class SiteTest < StoryTest
  test "hello world" do
    visit '/'
    assert current_path == '/'
  end
end

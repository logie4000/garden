require 'test_helper'

class SeasonTest < ActiveSupport::TestCase
  test "season is direct seeded" do
    season = seasons(:radish)
    assert season.direct_seeded?

    season = seasons(:tomato)
    assert !season.direct_seeded?
  end
end

class Calendar < ApplicationRecord
  has_one :image, as: :imageable

end

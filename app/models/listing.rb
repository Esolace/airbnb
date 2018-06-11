class Listing < ApplicationRecord
    belongs_to :user
    self.per_page = 10
end

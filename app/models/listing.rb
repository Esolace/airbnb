class Listing < ApplicationRecord
    mount_uploaders :avatars, AvatarUploader

    belongs_to :user
    self.per_page = 10
end

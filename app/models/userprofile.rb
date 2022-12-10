class Userprofile < ApplicationRecord
  belongs_to :user

  mount_uploader :user_avatar, UserprofileUploader

end

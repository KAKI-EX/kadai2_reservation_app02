class Userprofile < ApplicationRecord
  belongs_to :user

  mount_uploader :user_avatar, UserprofileUploader

  validates :self_introduce, presence: true,length: { maximum: 250 }
  validates :user_name, presence: true
  validates :user_avatar, presence: true

end

class Post < ApplicationRecord
  belongs_to :user
  has_many :reservations

  mount_uploader :room_photo, PostUploader #carrierwave用記載

  validates :user_id, presence: true
  validates :room_name, presence: true
  validates :room_price, presence: true, numericality: true
  validates :room_address_postcode, presence: true, numericality: true, length: {in: 7..7 }
  validates :room_address_prefecture, presence: true
  validates :room_address_town_village, presence: true
end

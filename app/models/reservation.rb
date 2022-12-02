class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :peaple_count, presence: true
end

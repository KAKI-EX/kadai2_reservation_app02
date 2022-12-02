class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :peaple_count, presence: true

  validate :check_in_check_out

  private

  def check_in_check_out
    if check_in.nil? || check_out.nil?

    elsif check_in >= check_out
      errors.add(:check_in,"またはチェックアウトの選択に誤りがあります。(日帰りの予約はできません)")
    end
  end
end

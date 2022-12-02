class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :check_in, presence: true
  validates :check_out, presence: true
  validates :people_count, presence: true

  validate :check_in_check_out

  private

  def check_in_check_out
    if check_in.nil? || check_out.nil?

    elsif check_in >= check_out || Date.today >= check_in
      errors.add(:check_in,"またはチェックアウトの選択に誤りがあります。(当日予約も不可)")
    end
  end
end

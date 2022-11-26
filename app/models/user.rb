class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :posts

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  mount_uploader :avatar, AvatarUploader #11/22 1000 アップローダーとの関連付け

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, format: {with: VALID_EMAIL_REGEX}, allow_blank: true
  validates :email, presence: true
  validates :name, presence: true
  validates :password, presence: true, length: { minimum: 6 }
end

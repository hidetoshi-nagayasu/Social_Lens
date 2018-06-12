class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :full_name, presence: true
  validates :user_name, presence: true, uniqueness: true
  has_many :posts
  has_many :comments
  has_many :likes, dependent: :destroy
end

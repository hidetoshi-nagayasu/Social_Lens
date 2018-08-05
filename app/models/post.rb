class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: :user
  mount_uploaders :images, ImageUploader
  serialize :images, JSON

  def like(user)
    likes.create(user_id: user.id)
  end

  def unlike(user)
    likes.find_by(user_id: user.id).destroy
  end

  # 現在のユーザーがいいねしてたらtrueを返す
  def like?(user)
      like_users.include?(user)
  end

  scope :subscribed, ->(followers) { where user_id: followers, is_deleted: 0 }

end

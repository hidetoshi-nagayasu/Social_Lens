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

  has_attached_file :avatar,
                      styles:  { medium: "300x300#", thumb: "100x100#" }
                      # url: "/assets/images/avatar" # 画像保存先のURL先
  validates_attachment_content_type :avatar,
                                      content_type: ["image/jpg","image/jpeg","image/png","image/gif"],
                                      presence: true,  # ファイルの存在チェック
                                      less_than: 5.megabytes # ファイルサイズのチェック
end

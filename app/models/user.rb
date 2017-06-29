class User < ApplicationRecord
  has_many :user_items, foreign_key: 'user_id', dependent: :destroy
  has_many :items, through: :user_items

  has_secure_password
  before_save { self.email.downcase! }
  
  validates :name, presence: true,
    length: { maximum: 50 }
  validates :email, presence: true,
    length: { maximum: 255 },
    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
    uniqueness: { case_sensitive: false }
  validates :fam_name, presence: true,
    length: { maximum: 50 }
  validates :giv_name, presence: true,
    length: { maximum: 50 }
  validates :fam_name_kana, presence: true,
    length: { maximum: 50 }
  validates :giv_name_kana, presence: true,
    length: { maximum: 50 }

end

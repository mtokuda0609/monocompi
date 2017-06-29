class Item < ApplicationRecord
  has_many :user_items, foreign_key: 'item_id', dependent: :destroy
  has_many :users, through: :user_items
  
  # validates :name, presence: true, length: { maximum: 255 }
  
end

class Item < ApplicationRecord
  belongs_to :user
  
  belongs_to :storage

  has_many :list_items
  has_many :lists, through: :list_items

  has_many_attached :images, dependent: :destroy
end

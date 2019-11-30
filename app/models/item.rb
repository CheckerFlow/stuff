class Item < ApplicationRecord
  belongs_to :storage

  has_many_attached :images, dependent: :destroy
end

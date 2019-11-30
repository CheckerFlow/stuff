class Storage < ApplicationRecord
    belongs_to :room
    has_many :items, dependent: :destroy

    has_many_attached :images, dependent: :destroy
end

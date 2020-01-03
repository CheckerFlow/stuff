class Room < ApplicationRecord
    belongs_to :user

    belongs_to :building

    has_many :storages, dependent: :destroy

    has_many_attached :images, dependent: :destroy
end

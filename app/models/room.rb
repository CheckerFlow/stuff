class Room < ApplicationRecord
    has_many :storages, dependent: :destroy

    has_many_attached :images, dependent: :destroy
end

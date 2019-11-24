class Room < ApplicationRecord
    has_many :storages, dependent: :destroy
end

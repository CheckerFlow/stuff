class List < ApplicationRecord
    has_many :list_items, dependent: :destroy

    belongs_to :user

    has_many :sharing_group_members, as: :shareable
end

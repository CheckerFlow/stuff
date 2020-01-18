class Building < ApplicationRecord
    belongs_to :user

    has_many :rooms, dependent: :destroy

    has_many_attached :images, dependent: :destroy    

    self.per_page = 12 

    has_many :sharing_group_members, as: :shareable

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :buildings, dependent: :destroy
  has_many :rooms, dependent: :destroy
  has_many :storages, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :lists, dependent: :destroy

  has_many :family_members, dependent: :destroy
end

class Studio < ApplicationRecord
  has_many :studio_users, dependent: :destroy
  has_many :users, through: :studio_users
end

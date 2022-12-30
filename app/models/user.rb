class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :email, :name, :member, presence: true
  validates :password, presence: true, allow_nil: true

  has_many :room_users, dependent: :destroy
  has_many :talk_rooms, through: :room_users
  has_many :messages, dependent: :destroy
  has_many :studio_users, dependent: :destroy
  has_many :studios, through: :studio_users
  attr_accessor :studio_ids
end

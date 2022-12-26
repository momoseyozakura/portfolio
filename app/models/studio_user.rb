class StudioUser < ApplicationRecord
  belongs_to :user
  belongs_to :studio

  before_create -> { self.id = SecureRandom.uuid }
end

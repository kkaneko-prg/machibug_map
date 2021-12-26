class Post < ApplicationRecord
  validates :photos, attached: true

  belongs_to :user
  has_many_attached :photos
end

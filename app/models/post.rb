class Post < ApplicationRecord
  validates :images, attached: true

  belongs_to :user
  has_many_attached :photos
end

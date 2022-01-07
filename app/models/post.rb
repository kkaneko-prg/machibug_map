class Post < ApplicationRecord
  validates :photos, attached: { message: 'を選択してください。' }

  belongs_to :user
  has_one :spot
  has_many_attached :photos
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  
  # bodyカラムは、必須項目であり、最長65535字までというバリデーション。
  validates :body, presence: true, length: { maximum: 65_535 }
end

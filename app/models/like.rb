class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post

  # validates_uniqueness_of :post_id, scope: :user_id
  # user_idとpost_idの組み合わせが1組しかないようにするバリデーション。
  validates :user_id, uniqueness: { scope: :post_id }
end
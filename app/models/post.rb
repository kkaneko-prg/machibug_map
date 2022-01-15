class Post < ApplicationRecord
  validates :photos, attached: { message: 'を選択してください。' }

  belongs_to :user
  # postのレコードを削除したときに紐付いていたspotを同時に削除
  has_one :spot, dependent: :destroy
  # ２つのモデルがアソシエーションで結びついている時、２つまとめてレコードを投稿・更新できるRailsメソッド
  # コントローラでの記述と組み合わせて使う
  accepts_nested_attributes_for :spot
  has_many_attached :photos
  # dependent: :destroyにより、postのレコードを削除したときに紐付いているcomments/likesも同時に削除する
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy
  # 投稿が誰にいいねされているのかを取得できる。
  has_many :liked_users, through: :likes, source: :user
end

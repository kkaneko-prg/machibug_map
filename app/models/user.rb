class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
  # メールアドレスは、'@'や'.'など、emailとして必須の項目があることで登録可能。
  # .freezeを付けて、定義した定数を凍結（内容の変更を禁止）する。
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  # uniqueness: { case_sensitive: false }で、一意性の確認とメールアドレスの大文字・小文字の区別を無くしている。
  validates :email, { presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false } }

  # パスワードは、半角アルファベット（大文字・小文字)・半角数字のみ登録可能であることの正規表現。
  # .freezeを付けて、定義した定数を凍結（内容の変更を禁止）する。
  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/.freeze
  # パスワードは、8文字以上/半角英数字のみ/確認用パスワードと一致していることが条件。
  # if以降は、ユーザーがパスワード以外のプロフィールを変更する場合に、パスワードの入力を省略できるようにしている。
  validates :password, confirmation: true, length: { minimum: 8 }, format: { with: VALID_PASSWORD_REGEX, message: '半角英数字のみ使用可能です' }, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }
  # reset_password_tokenカラムが一意であることの制約に加え、allow_nil: trueをつけることでnullを許容している。
  validates :reset_password_token, uniqueness: true, allow_nil: true

  # dependent: :destroyにより、Userを削除したときに、紐付いているposts/comments/likesも同時に削除できる。
  has_many :posts,    dependent: :destroy # @user.postsが使えるようになる。
  has_many :comments, dependent: :destroy
  has_many :likes,    dependent: :destroy
  # userがどの投稿をいいねしているのかを取得できる。
  has_many :liked_posts, through: :likes, source: :post

  # 一般ユーザー、管理者ユーザー
  enum role: { general: 0, admin: 1 }

  def own?(object)
    id == object.user_id
  end

  # ユーザーが投稿に対して、すでにいいねをしているのかどうかを判定する。
  def already_liked?(post)
    likes.exists?(post_id: post.id)
  end
end

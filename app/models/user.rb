class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
  # メールアドレスは、'@'や'.'など、emailとして必須の項目があることで登録可能。
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # uniqueness: { case_sensitive: false }で、一意性の確認とメールアドレスの大文字・小文字の区別を無くしている。
  validates :email, {presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }}

  #　パスワードは、半角アルファベット（大文字・小文字)・半角数字のみ登録可能であることの正規表現。
  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/
  #　パスワードは、8文字以上/半角英数字のみ/確認用パスワードと一致していることが条件。
  # if以降は、ユーザーがパスワード以外のプロフィールを変更する場合に、パスワードの入力を省略できるようにしている。
  validates :password, confirmation: true, length: { minimum: 8 },
             format: { with: VALID_PASSWORD_REGEX, message: '半角英数字のみ使用可能です' },
             if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :posts 
end

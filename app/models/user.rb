class User < ApplicationRecord
  authenticates_with_sorcery!

  validates :name, presence: true, uniqueness: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: true

  #　パスワードは、半角アルファベット（大文字・小文字)・半角数字のみ可能な正規表現。
  VALID_PASSWORD_REGEX = /\A[a-zA-Z0-9]+\z/
  #　パスワードは、8文字以上/半角英数字のみ/確認用パスワードと一致していることが条件。
  # if以降は、ユーザーがパスワード以外のプロフィールを変更する場合に、パスワードの入力を省略できるようにしている。
  validates :password, confirmation: true, length: { minimum: 8 },
             format: { with: VALID_PASSWORD_REGEX, message: '半角英数字のみ使用可能です' },
             if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  has_many :posts 
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nick_name, presence: true
  validates :name, presence: true
  validates :furigana_name, presence: true
  validates :sex, presence: true
  validates :email, presence: true
  # パスワード7文字以上
  validates :encrypted_password, presence: true, length: { minimum: 7 }

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  
  validates :nick_name,     presence: true
  validates :name,          presence: true
  validates :furigana_name, presence: true
  validates :sex,           presence: true
  validates :email,         presence: true
  # パスワード7文字以上
  validates :encrypted_password, presence: true, length: { minimum: 7 }

  # ゲストログイン
  GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
      # find_or_create_by データの検索と作成を自動的に判断して処理を行うメソッド
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        # SecureRandom.urlsafe_base64 ランダムな文字列を生成するメソッド
        user.password = SecureRandom.urlsafe_base64
        user.name = 'guestuser'
      end
    end

    # ゲストユーザーかどうか判別し、true/falseを返す
    def guest_user?
      email == GUEST_USER_EMAIL
    end


    mount_uploader :top_image, TopImageUploader
  end

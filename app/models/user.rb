class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :comments,  dependent: :destroy
  has_many :posts,     dependent: :destroy
  has_many :favorites, dependent: :destroy
  # プロフィール画像
  has_one_attached :top_image

  validates :nick_name,     presence: true
  validates :name,          presence: true
  validates :furigana_name, presence: true
  validates :sex,           presence: true
  validates :email,         presence: true
  validates :encrypted_password, presence: true, length: { minimum: 7 }

  # ユーザーのプロフィール画像を指定したサイズにリサイズ処理
  def get_top_image(width, height)
    if top_image.attached? && top_image.blob.present?
      top_image.variant(resize_to_limit: [width, height]).processed
    else
      # ファイルがアタッチされていない場合の処理（デフォルト画像など）
      image_tag('default-image.jpg', size: "#{width}x#{height}")
    end
  end

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
  end

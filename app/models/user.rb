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

  validates :nick_name,     presence: true, unless: :guest?
  validates :name,          presence: true, unless: :guest?
  validates :furigana_name, presence: true, unless: :guest?
  validates :sex,           presence: true, unless: :guest?
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
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "ゲスト"
      end
    end

    # ゲストユーザーかどうか判別し、true/falseを返す
    def guest_user?
      email == GUEST_USER_EMAIL
    end

  # 退会機能
  # 有効会員はtrue、退会済み会員はfalse
  enum is_active: {Available: true, Invalid: false}

  #is_activeがtrueの場合は有効会員(ログイン可能)
  def active_for_authentication?
    super && (self.is_active === "Available")
  end

  def withdraw
    update(is_active: false)
  end

end

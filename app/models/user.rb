class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         validates :nick_name,          presence: true, unless: :guest_user?, on: :update
         validates :name,               presence: true, unless: :guest_user?
         validates :furigana_name,      presence: true, unless: :guest_user?
         validates :sex,                presence: true, unless: :guest_user?
         validates :email,              presence: true
         validates :encrypted_password, presence: true, length: { minimum: 7 }


  has_many :comments,  dependent: :destroy
  has_many :posts,     dependent: :destroy
  has_many :favorites, dependent: :destroy
  # プロフィール画像
  has_one_attached :top_image


  # ユーザーのプロフィール画像を指定したサイズにリサイズ処理
  def get_top_image_url(width, height)
    if top_image.attached? && top_image.blob.present?
      top_image.variant(resize: "#{width}x#{height}").processed.url
    else
      # ファイルがアタッチされていない場合の処理（デフォルト画像など）
      'no_image.jpg'
    end
  end

  # ゲストログイン
    GUEST_USER_EMAIL = "guest@example.com"

    def self.guest
      find_or_create_by!(email: GUEST_USER_EMAIL) do |user|
        user.password = SecureRandom.urlsafe_base64
        user.name = "ゲスト"
        # ゲストユーザーのデフォルトのニックネームを設定
        user.nick_name = "ゲスト"
        user.furigana_name = "ゲスト"
        user.sex = "male"
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
  
  def user_status
    # user_status の定義（is_active が "Available" の場合は "有効"、それ以外は "退会"）
    is_active == "Available" ? "有効" : "退会"
  end

end

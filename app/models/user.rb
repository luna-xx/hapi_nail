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
    unless top_image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      top_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    top_image.variant(resize_to_limit: [width, height]).processed
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
  
  # 検索機能
  def self.looks(search, word)
    # 完全一致
    if search == "perfect_match"
      @user = User.where("nick_name LIKE ? or introduction LIKE ?", "%#{word}%", "%#{word}%")
    # 前方一致
    elsif search == "forward_match"
      @user = User.where("nick_name LIKE ? or introduction LIKE ?", "%#{word}%", "%#{word}%")
    # 後方一致
    elsif search == "backward_match"
      @user = User.where("nick_name LIKE ? or introduction LIKE ?", "%#{word}%", "%#{word}%")
    # 部分一致
    elsif search == "partial_match"
      @user = User.where("nick_name LIKE ? or introduction LIKE ?", "%#{word}%", "%#{word}%")
    else
      @user = User.all
    end
  end

end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # devise :database_authenticatable, :registerable,
  #       :recoverable, :rememberable, :validatable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_many :post, dependent: :destroy
  has_one_attached :top_image
  
  validates :nick_name,     presence: true
  validates :name,          presence: true
  validates :furigana_name, presence: true
  validates :sex,           presence: true
  validates :email,         presence: true
  validates :encrypted_password, presence: true, length: { minimum: 7 }
  
  def get_top_image
    unless top_image.attached?
      file_path = Rails.root.join('app/assets/images/sample-author1.jpg')
      top_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    top_image.variant(resize_to_limit: [width, height]).processed
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

    mount_uploader :top_image, TopImageUploader
    
    
  end

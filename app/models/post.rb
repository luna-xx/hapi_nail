class Post < ApplicationRecord
  
  belongs_to :user
  has_many :comments,  dependent: :destroy
  has_many :posttags,  dependent: :destroy
  has_many :tags,      through: :posttags
  has_many :favorites, dependent: :destroy
  has_many_attached :images
  has_one_attached  :image
  
  validates :title,  presence: true
  validates :text,   presence: true
  validates :image,  presence: true
  
  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end
  
  def save_tags(tags)
    # タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    # 現在取得したタグから送られてきたタグを除いてold_tagとする
    old_tags = current_tags - tags
    # 送信されてきたタグから現在存在するタグを除いたタグをnewとする
    new_tags = tags - current_tags
    
    # 古いタグを消す
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(name:old_name)
    end
    
    # 新しいタグを保存
    new_tags.each do |new_name|
      tag = Tag.find_or_create_by(name:new_name)
      self.tags << tag
    end
  end
  
  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
  
  # 検索機能
  def self.looks(search, word)
    # 完全一致
    if search == "perfect_match"
      @post = Post.where("title LIKE ? or text LIKE ?", "%#{word}%", "%#{word}%")
    # 前方一致
    elsif search == "forward_match"
      @post = Post.where("title LIKE ? or text LIKE ?", "%#{word}%", "%#{word}%")
    # 後方一致
    elsif search == "backward_match"
      @post = Post.where("title LIKE ? or text LIKE ?", "%#{word}%", "%#{word}%")
    # 部分一致
    elsif search == "partial_match"
      @post = Post.where("title LIKE ? or text LIKE ?", "%#{word}%", "%#{word}%")
    else
      @post = Post.all
    end
  end
  
end

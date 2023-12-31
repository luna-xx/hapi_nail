class Tag < ApplicationRecord
  has_many :posttags, dependent: :destroy
  has_many :posts, through: :posttags
  
  validates :name, presence: true, length: {maximum: 50 }
end

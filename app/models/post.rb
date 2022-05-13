class Post < ApplicationRecord
  extend FriendlyId
    friendly_id :title, use: :slugged 

  belongs_to :user
  has_many :comments, dependent: :destroy

  #validates :titletag, presence: true, length: {minimum: 1, maximum: 60 }
  #validates :meta, presence: true, length: {minimum: 150, maximum: 320 }
  #validates :title, presence: true
  #validates :body, presence: true

end

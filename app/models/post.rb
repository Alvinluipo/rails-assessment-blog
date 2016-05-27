class Post < ActiveRecord::Base
  has_many :users, through: :comments
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: {minimum: 5 }
  validates :body, presence: true

end

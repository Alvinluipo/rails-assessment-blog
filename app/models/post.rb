class Post < ActiveRecord::Base

  has_many :tag_posts
  has_many :tags, through: :tag_posts
  belongs_to :user
  #accepts_nested_attributes_for :tags




  has_many :users, through: :comments
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5 }
  validates :body, presence: true

  def tags_attributes=(tag_attributes)
    tag_attributes.values.each do |tag_attributes|
      tag = Tag.find_or_create_by(tag_attributes)
      self.tags << tag
      
    end
  end


  def self.most_popular_post
  
    Post.order("comments_count DESC").take

  end

end

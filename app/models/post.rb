class Post < ActiveRecord::Base

  has_many :tag_posts
  has_many :tags, through: :tag_posts
  belongs_to :user
  accepts_nested_attributes_for :tags




  has_many :users, through: :comments
  has_many :comments, dependent: :destroy

  validates :title, presence: true, length: {minimum: 5 }
  validates :body, presence: true

  def tags_attributes=(tags_attributes)
    tags_attributes.each do |i, tag_attributes|
      if Tag.find_by_id(tag_attributes[:id])
        Tag.update(tag_attributes[:id], tag_attributes)
      elsif tag_attributes[:content] != ""
        self.tags.build(tag_attributes)
      end
    end
  end

  def most_popular_post
    @popular_post = Post.all.each do |comment|
      comment.count.order('created_at DESC')
    end
  end

end

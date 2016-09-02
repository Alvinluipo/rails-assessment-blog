class CommentSerializer < ActiveModel::Serializer
  attributes :id, :name, :body

  has_one :post
end

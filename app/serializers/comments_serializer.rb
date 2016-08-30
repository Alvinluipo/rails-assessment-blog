class CommentsSerializer < ActiveModel::Serializer
  attributes :id, :name, :body
end

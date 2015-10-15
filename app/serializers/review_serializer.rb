class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :stars, :author, :body
end

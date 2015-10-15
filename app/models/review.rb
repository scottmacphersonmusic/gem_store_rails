class Review < ActiveRecord::Base
  validates :stars, :author, :body, presence: true

  belongs_to :product
end

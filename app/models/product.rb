class Product < ActiveRecord::Base
  validates :name, :price, presence: true

  has_many :reviews
end

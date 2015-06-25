class Category < ActiveRecord::Base
  has_many :category_postships
  has_many :posts, :through => :category_postships
end

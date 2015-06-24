class CategoriesController < ApplicationController
  has_many :category_groupship
  has_many :posts, :through => :category_groupship
end

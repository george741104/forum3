class Post < ActiveRecord::Base
  validates_presence_of :title
  has_many :comments
  belongs_to :user
  has_many :category_postship
  has_many :categories, :through => :category_postship
end

class Post < ActiveRecord::Base
  validates_presence_of :title

  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :category_postships
  has_many :categories, :through => :category_postships
end

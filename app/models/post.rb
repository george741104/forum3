class Post < ActiveRecord::Base
  validates_presence_of :title, :content

  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :category_postships
  has_many :categories, :through => :category_postships


  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end

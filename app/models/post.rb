class Post < ActiveRecord::Base
  validates_presence_of :title, :content

  has_many :comments, :dependent => :destroy
  belongs_to :user
  has_many :category_postships
  has_many :categories, :through => :category_postships


  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  has_many :favorites, :dependent => :destroy
  has_many :users, :through => :favorites

  acts_as_ordered_taggable
  #attr_accessible :content, :name, :tag_list
  acts_as_taggable_on :tags
  acts_as_ordered_taggable_on :skills, :interests
end


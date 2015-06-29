class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts
  has_many :comments

  has_one :user_profile, :dependent => :destroy

  include Gravtastic

  gravtastic

  def short_name
    self.email.split('@').first
  end

end

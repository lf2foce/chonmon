class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #validates :user_name, presence: true, length: { minimum: 3, maximum: 16 }
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  #chua chay
  #def self.is_admin?
  #	self.role ==  "admin"
  #	#self.where(role: "admin")
  #end

  scope :admin, -> { where(role: "admin") }
  scope :user, -> { where(role: "user") }

  #role
	  #ROLES = {0 => :guest, 1 => :user, 2 => :moderator, 3 => :admin}
#
	  #attr_reader :role
#
	  #def initialize(role_id = 0)
	  #  @role = ROLES.has_key?(role_id.to_i) ? ROLES[role_id.to_i] : ROLES[0]
	  #end
#
	  #def role?(role_name)
	  #  role == role_name
	  #end
	  #end role
    def likes?(post)

      post.likes.where(user_id: id).any?

    end
    #test
    def heart!(post)
      self.likes.create!(post_id: post.id)
    end

    # destroys a heart with matching post_id and user_id
    def unheart!(post)
      heart = self.likes.find_by_post_id(post.id)
      heart.destroy!
    end

    # returns true of false if a post is hearted by user
    def heart?(post)
      self.likes.find_by_post_id(post.id)
    end
end

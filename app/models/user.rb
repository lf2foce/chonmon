class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  #validates :user_name, presence: true, length: { minimum: 3, maximum: 16 }
  has_many :posts
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
end

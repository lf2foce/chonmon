class Category < ApplicationRecord
	has_many :posts

	def self.search(search)  
	   where("lower(posts.title) LIKE :search OR lower(categories.name) LIKE :search", search: "%#{search.downcase}%").uniq   
	end

end

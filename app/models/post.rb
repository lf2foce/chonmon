class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_rich_text :body
  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_commit :create_hash_tags, on: [:create]
  after_commit :update_hash_tags, on: [:update]

  def update_hash_tags
  	hash_tags.destroy_all
	  extract_name_hash_tags.each do |name|
	    hash_tags.create(name: name)
	  end
	end

  def create_hash_tags
	  extract_name_hash_tags.each do |name|
	    hash_tags.create(name: name)
	  end
	end
  def extract_name_hash_tags
	  content.to_s.scan(/#\w+/).map{|name| name.gsub("#", "")}
	end
  
  include PgSearch::Model
    pg_search_scope :search_by_title, against: [:title, :content]
end

class Post < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_rich_text :body
  has_one_attached :image
  has_many :post_hash_tags
  has_many :hash_tags, through: :post_hash_tags
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  scope :last_n_days, ->(days) {where('created_at > ?', days)}
  scope :last_5_days, ->{order('created_at DESC')}

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :interests, :categories
  $interests = ['spacious', 'delicious', 'not_be_back', 'Overpriced', 'rude'] #???

  after_commit :create_hash_tags, on: [:create]
  after_commit :update_hash_tags, on: [:update]
  after_create_commit :add_image_to_posts


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

  def add_image_to_posts
    if !image_url.present?
      update!(image_url: "https://images.unsplash.com/photo-1414235077428-338989a2e8c0?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1050&q=80")
    end
  end
  # test search pg
  #def self.search(search)
  #  where("title LIKE ?", "%#{search}%") 
  #  where("content LIKE ?", "%#{search}%")
  #end

  def self.recently(recently)
    Post.last_n_days(Time.now + 1 - recently.to_i.days)
  end
  
  include PgSearch::Model
    pg_search_scope :search_by_title, against: [:title, :content],
                    associated_against: {
                                          categories: [:name],
                                          interests: [:name],
                                          tags: [:name]
                                        }
  def self.search(search)  
     where("lower(posts.title) LIKE :search OR lower(categories.name) LIKE :search", search: "%#{search.downcase}%").uniq   
  end                                      
end

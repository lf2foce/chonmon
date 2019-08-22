class Post < ApplicationRecord
  belongs_to :category
  has_rich_text :body
  
  include PgSearch
    pg_search_scope :search_by_title, against: [:title, :content]
end

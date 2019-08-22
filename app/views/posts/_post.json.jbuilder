json.extract! post, :id, :title, :content, :image_url, :category_id, :rating, :created_at, :updated_at
json.url post_url(post, format: :json)

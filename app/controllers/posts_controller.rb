class PostsController < ApplicationController

  before_action :set_post, only: [ :show, :edit, :update, :destroy]


  # GET /posts
  # GET /posts.json
  def index
    @comment = Comment.new
 
    @top5posts = Post.order('title DESC').limit(5)
    @all_posts = Post.all
    
    @post = current_user.posts.build
    if @post.save 
      redirect_to @post, notice: 'Post was successfully created.'
      #format.json { render :show, status: :created, location: @post }
    end

    handle_search_name
    handle_filters
    
    respond_to do |format|
        format.html
        format.js
    end

    @tags = ["cơm", "cafe", "pizza"]
  end

  def click_tag
    #thu test category
    @tags = ["cơm", "cafe", "pizza"]
    if params[:basic]
      @posts = Post.where("posts.title LIKE :search OR posts.content LIKE :search", search: "%#{params[:basic]}%")
      .order("created_at DESC") 
      flash[:notice] = "There are <b>#{@posts.count}</b> in this category".html_safe
      
    else
      @posts = Post.all
    end
    render 'index'

    #still worked
    #if params[:basic]
    #  @posts = Post.where("title LIKE ? OR content LIKE ?", "%" + params[:basic] + "%", "%" + params[:basic] + "%") 
    #  flash[:notice] = "There are <b>#{@posts.count}</b> in this category".html_safe
    #  
    #else
    #  @posts = Post.all
    #end

  end

  def recent
    @posts = Post.last_5_days
    render action: :index
  end

  def tagged_with
    if params[:post_tag].present?
      @posts = Post.tagged_with(params[:post_tag])
    end 
      render action: :index
  end


  # GET /posts/1
  # GET /posts/1.json
  def show
    @comment = Comment.new

    pre_like = @post.likes.find { |like| like.user_id == current_user.id}
    if pre_like
      @like = current_user.likes.find_by(post_id: @post.id)
    else
      @like = current_user.likes.new(post_id: @post.id)
    end

  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def tag_cloud
    @tags = Post.tag_counts_on(:tags)
  end

  def tagged
  if params[:tag].present?
    @posts = Post.tagged_with(params[:tag])
  else
    @posts = Post.all
  end
end

  private
    def handle_search_name
      if params[:pg_search]
        @posts = Post.search_by_title(params[:pg_search])
        #@count = @posts.count
      else
        @posts = Post.all 
        #@posts = Post.paginate(:page => params[:page], :per_page => 20)
        #redirect_to root_path if @posts.empty?
      end
    end
    

        #test search
    def handle_filters    
      #if params[:category]
      #  @posts = Post.where("posts.category_id IN (?)", params[:category]) 
        if params[:filter]
          @filter = params["filter"]["types"].concat(params["filter"]["interests"]).flatten.reject(&:blank?)
          @posts = @filter.empty? ? @posts : Post.all.tagged_with(@filter, any: true)
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :image_url, :category_id, :rating, :body, :tag_list, :interest_list, :image, :price, :address)
    end
end

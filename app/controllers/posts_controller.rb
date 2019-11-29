class PostsController < ApplicationController

  before_action :set_post, only: [ :show, :edit, :update, :destroy]


  # GET /posts
  # GET /posts.json
  def index
     @comment = Comment.new
    #@posts = Post.all
    if params[:filter]
      @posts = Post.search_by_title(params[:filter])
      @count = @posts.count
    else
      #@posts = Post.all
      @posts = Post.paginate(:page => params[:page], :per_page => 20)
      redirect_to root_path if @posts.empty?
    end

    #test search
    if params[:search]
      @posts = Post.search(params[:search]).order("created_at DESC")
    else
      @posts = Post.all.order('created_at DESC')
    end
    #test search
    if params[:d]
      @posts = Post.recently(params[:d]).order("created_at DESC")
    else
      @posts = Post.all.order('created_at DESC')
    end

    @top5posts = Post.order('title DESC').limit(5)
    @all_posts = Post.all
    
    @post = current_user.posts.build
    if @post.save 
      format.html { redirect_to @post, notice: 'Post was successfully created.' }
      format.json { render :show, status: :created, location: @post }
    end




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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :image_url, :category_id, :rating, :body, :tag_list, :interest_list)
    end
end

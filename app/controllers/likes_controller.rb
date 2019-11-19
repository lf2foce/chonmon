class LikesController < ApplicationController
  before_action :find_post
  before_action :find_like , only: [:destroy]

  def already_liked?
	  Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
	end

  def create
    if already_liked?
	    flash[:notice] = "You can't like more than once"
	  else
	    @post.likes.create(user_id: current_user.id)
	    respond_to do |format|
	    		format.js
	    end
	  end
	  
  end

  def destroy
	  #if !(already_liked?)
	  #  flash[:notice] = "Cannot unlike"
	  #else
	  	@like.destroy
	  	respond_to do |format|
	    		format.js { render :template => 'likes/destroy.js.erb', :layout => false }
	    end
	    
	  #end
	  #redirect_to posts_path
	end

  private
  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_like
	   #@like = @post.likes.find(params[:id])
	   @like = current_user.likes.find_by(post_id: @post.id)
	end
end
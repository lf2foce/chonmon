class CommentsController < ApplicationController
  before_action :set_post
	def new
    @comment = Comment.new
  end

  def create
    @comment = @post.comments.create(msg_params)
    if @comment.save
      ActionCable.server.broadcast "room_channel",
                                      content: @comment.content, post_id: @post.id
                                         
    else
      
    end
  end

  private
  def msg_params
    params.require(:comment).permit(:content)
  end

  def set_post
      @post = Post.find(params[:post_id])
  end

end

class CommentsController < ApplicationController
	def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(msg_params)
    if @comment.save
      ActionCable.server.broadcast "room_channel",
                                      content: @comment.content      
    else
      
    end
  end

  private
  def msg_params
    params.require(:comment).permit(:content)
  end
  
end

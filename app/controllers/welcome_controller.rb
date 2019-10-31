class WelcomeController < ApplicationController
  def index
  	@comment = Comment.new
  end
end

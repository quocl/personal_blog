class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    respond_to do |format|
       format.html { redirect_to post_path(@post) }
       format.js
   end
  end
  
  def destroy
    @comment = Comment.find(params[:id])
    @post = @comment.post
    if @post.user == current_user
      @comment.destroy
    end
    respond_to do |format|
      format.html { redirect_to @post }
      format.json { head :no_content }
    end
  end
end

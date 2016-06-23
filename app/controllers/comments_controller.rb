class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment =  @post.comments.new(params[:comment].permit(:name, :body))
    @comment.user_id = current_user.id 
    @comment.post_id = @post.id
    if @comment.save

      redirect_to post_path(@post)
    else
      flash[:notice] = "Comment not created"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to post_path(@post)
  end

end

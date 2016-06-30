class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:comment][:post_id])
    @comment =  @post.comments.build(params[:comment].permit(:name, :body))
    @comment.user_id = current_user.id 
    @comment.post_id = @post.id
    if @comment.save

      redirect_to user_post_path(current_user.id, @post)
    else
      flash[:notice] = "Comment not created"
    end
  end

  def destroy
    @post = Post.find(params[:comment][:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to user_post_path(current_user.id, @post)
  end

end

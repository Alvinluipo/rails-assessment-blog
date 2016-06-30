class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  def index
    @posts = Post.all.order('created_at DESC')
  end

  def new
    @user = current_user
    @post = Post.new
    @post.tags << Tag.new
    @tags = Tag.all
    #@tag = Tag.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = current_user.id
      
    if @post.save
      redirect_to user_posts_path(@post)
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
  end

  def edit
    @user = current_user
    @post = Post.find(params[:id])
  end

  def update

    @post = Post.find(params[:id])
    if @post.update(params[:post].permit(:title, :body))
      redirect_to  user_posts_path(@post)
    else 
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    redirect_to root_path
  end




  private 
    def post_params
      params.require(:post).permit(:title, :body, {tag_ids: []}, :tags_attributes => [:content])
    end

end
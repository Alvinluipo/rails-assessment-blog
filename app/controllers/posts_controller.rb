class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]


  def index
    @popular = Post.most_popular_post

    
    if params[:user_id]
      @user = User.find(params[:user_id])
      @posts = @user.posts.order('created_at DESC')
    else

      @posts = Post.all.order('created_at DESC')
    end

  end

  def new
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @post = Post.new
      3.times do 
        @post.tags.build
        
      end
    #@tag = Tag.new
  end

  def create
    if params[:user_id]
      @user = User.find(params[:user_id])
    else
      @user = current_user
    end
    @post = Post.new(post_params)


    @post.user_id = @user.id
      
    if @post.save
      redirect_to user_posts_path(@user)
    else
      3.times do 
        @post.tags.build
      end
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
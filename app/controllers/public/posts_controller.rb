class Public::PostsController < ApplicationController
  def index
    @posts = Post.where(is_public: true)
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params) 
    post.user_id = current_user.id
    if post.save
      flash[:success] = "投稿をしました"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      flash[:success] = "編集を完了しました"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :content, :visibility, :group_id)
  end
end

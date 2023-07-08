class Public::PostsController < ApplicationController
  def index
    @posts = Post.where(is_public: true)
  end

  def show
    
  end

  def new
    @post = Post.new
  end
  
  def create
    post = Post.new(post_params) 
    post.user_id = current_user.id
    if post.save
      flash[:success] = "投稿しました"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    if @post.save(post_params)
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

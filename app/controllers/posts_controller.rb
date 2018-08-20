class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /posts
  # GET /posts.json
  def index
    @relationship = Relationship.where(follower_id: current_user.id)

    # ログインユーザーのIDとフォローしているユーザーのIDを配列化
    ids = [];
    @relationship.each do |relationship|
      ids.push(relationship.following_id)
    end
    ids.push(current_user.id)
    @posts = Post.includes(:user).where(user_id: ids, is_deleted: 0).order('id DESC')
    @post = Post.new
    @comments = Comment.where(is_deleted: 0).includes(:post).all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    # @post = Post.find(params[:id])
    @posts = Post.includes(:user).where(id: params[:id])
    @comments = Comment.where(post_id: params[:id], is_deleted: 0).includes(:user)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(text: post_params[:text], user_id: current_user.id, images: post_params[:images])

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: '投稿完了しました。', class: "alert alert-success" }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: '編集完了しました。' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.update(is_deleted: 1, deleted_at: DateTime.now)
    respond_to do |format|
      format.html { redirect_to posts_url, notice: '削除完了しました。' }
      format.json { head :no_content }
    end
  end

  def mypage
    @user = User.find_by(user_name: params[:user_name])
    @posts = Post.includes(:user).order('id DESC').where(user_id: @user.id, is_deleted: 0)
    @comments = Comment.where(is_deleted: 0).includes(:post).all
    @post_count = Post.where(user_id: @user.id).count
    @like_count = Like.where(user_id: @user.id).count
    @inbound_like_count = @posts.sum(:likes_count)
  end

  def search
    @posts = Post.includes(:user).where('text LIKE ?', "%#{params[:keyword]}%").where(is_deleted: 0).order('created_at DESC')
    @post = Post.new
    @comments = Comment.where(is_deleted: 0).includes(:post).all
    @keyword = params[:keyword]
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:text, :last_name, {images: []})
    end
end

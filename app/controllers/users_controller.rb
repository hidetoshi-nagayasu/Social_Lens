class UsersController < ApplicationController

    def show
    end

    def mypage
        @user = User.find_by(user_name: params[:user_name])
        @posts = Post.includes(:user).order('id DESC').where(user_id: @user.id, is_deleted: 0)
        @comments = Comment.where(is_deleted: 0).includes(:post).all
        @post_count = Post.where(user_id: @user.id).count
        @like_count = Like.where(user_id: @user.id).count
        @inbound_like_count = @posts.sum(:likes_count)
    end

    def following
        @title = "フォロー"
        @user = User.find(params[:id])
        @users = @user.followings
    render 'show_follow'
    end

    def followers
        @title = "フォロワー"
        @user = User.find(params[:id])
        @users = @user.followers
        render 'show_follow'
    end

end

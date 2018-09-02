class UsersController < ApplicationController

    def show
    end

    def mypage
        @user = User.find_by(user_name: params[:user_name])
        @followers_count = @user.followers.count
        @follow_count = @user.followings.count
        @posts = Post.includes(:user).order('id DESC').where(user_id: @user.id, is_deleted: 0)
        @comments = Comment.where(is_deleted: 0).includes(:post).all
        @post_count = Post.where(user_id: @user.id, is_deleted: 0).count
        @like_count = Like.where(user_id: @user.id).count
        @inbound_like_count = @posts.sum(:likes_count)
    end

    def following
        @title = "Follow List"
        @user = User.find(params[:id])
        @users = @user.followings
        @followers_count = @user.followers.count
        @follow_count = @user.followings.count
        @is_follower = 0
        render 'show_follow'
    end

    def followers
        @title = "Follower List"
        @user = User.find(params[:id])
        @users = @user.followers
        @followers_count = @user.followers.count
        @follow_count = @user.followings.count
        @is_follower = 1
        render 'show_follow'
    end

end

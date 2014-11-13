require_relative "../../config/environment"

class UsersController < ApplicationController 

  get '/users' do
    @users = User.all
    erb :users
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    @tweets = @user.tweets
    @followers = @user.follows
    @followings = @user.followed_users
    erb :user
  end

  post '/users/follow' do 
    @following = User.find(params[:following_id])
    Follower.create(user_id: params[:following_id], follower_id: params[:follower_id])
    Following.create(user_id: params[:follower_id], following_id: params[:following_id])
    redirect "/users/#{@following.id}"
  end

end
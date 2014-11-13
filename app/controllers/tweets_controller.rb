require_relative "../../config/environment"

class TweetsController < ApplicationController 

  get '/tweets' do
    @tweets = Tweet.all
    @users = User.all
    erb :tweets
  end

  post '/tweets' do
    Tweet.create(:user_id => params[:user_id], :status => params[:status])
    redirect '/tweets'
  end
  
end
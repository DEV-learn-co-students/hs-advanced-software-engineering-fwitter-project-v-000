require_relative "../../config/environment"

class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'fwitter'
  end

  configure :development do
    set :database, "sqlite3:///db/database.db"
  end

  helpers do
    def signed_in?
      session[:id]
    end

    def current_user
      current_user = User.find_by(password: session[:id])
    end

    def error
      session[:error]
    end
  end

  get '/sign-in' do
    erb :signin
  end

  post '/sign-in' do
    @user = User.find_by(email: params[:email])
    if BCrypt::Password.new(@user.password) == params[:password]
      session[:id] = BCrypt::Password.new(@user.password)
      session[:error] = nil
      redirect "/users/#{@user.id}"
    else
      session[:error] = "Wrong email or password. Please try again."
      redirect "/sign-in"
    end
  end

  post '/sign-up' do
    password_hash = BCrypt::Password.create(params[:password])
    @user = User.new(name: params[:name], email: params[:email], password: password_hash)
    if @user.save
      session[:id] = password_hash
      session[:error] = nil
      redirect "/users/#{@user.id}"
    else
      session[:error] = "You've already signed up with that email address."
      redirect "/sign-in"
    end
  end

  get '/sign-out' do
    session[:id] = nil
    session[:error] = nil
    redirect '/tweets'
  end


end
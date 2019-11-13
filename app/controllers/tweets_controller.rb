class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      @user = User.find(session[:user_id])
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get 'tweets/:slug' do
    @tweet = Tweet.find(params)
    erb :'/show_tweet'
  end

end

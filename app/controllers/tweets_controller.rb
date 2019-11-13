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

  get '/tweets/new' do
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if logged_in?
      if params[:content] !=""
        @tweet = Tweet.new({user: current_user, content: params[:content]})
        if @tweet.save
          redirect to "/tweets/#{@tweet.id}" 
        else
          redirect to'/tweets/new'
        end
      else
        redirect to'/tweets/new'
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do 
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :"/tweets/edit_tweet"
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find(params[:id])
        if @tweet.user == current_user &&@tweet.content !=""
          if @tweet.update(content: params[:content])
            redirect to "/tweets/#{@tweet.id}"
          else
            redirect to "/tweets/#{@tweet.id}/edit"
          end
        else
          redirect to "/tweets/#{@tweet.id}/edit"
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if current_user
      @tweet = Tweet.find(params[:id])
      if @tweet.user == current_user
        @tweet.destroy
        redirect to '/tweets'
      end
    else
      erb :'/tweets/tweets'
    end
  end


end

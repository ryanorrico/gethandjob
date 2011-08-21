class HomeController < ApplicationController
  def index

  end

  def shake


     user = User.where(uid: session[:uid]).first

      # get your api keys at https://www.linkedin.com/secure/developer
      client = LinkedIn::Client.new('heue86hmveky', 'h1aewkKShIUwxfnL')
      rtoken = client.request_token.token
      rsecret = client.request_token.secret



      # or authorize from previously fetched access keys
      client.authorize_from_access(user.token, user.secret)

      @client = client.profile

  end

  def activate

    user = User.where(uid: session[:uid]).first

    # get your api keys at https://www.linkedin.com/secure/developer
    client = LinkedIn::Client.new('heue86hmveky', 'h1aewkKShIUwxfnL')
    rtoken = client.request_token.token
    rsecret = client.request_token.secret



    # or authorize from previously fetched access keys
    client.authorize_from_access(user.token, user.secret)

    @connections = client.connections

    # connections["all"].each do |connection|
      # p connection["first_name"]
      # p connection["first_name"]
      # p connection["industry"]
      # p connection["picture_url"]
    # end


    p @connections

  end


end


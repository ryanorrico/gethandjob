class SessionsController < ApplicationController
  
  def create
    auth = request.env['omniauth.auth']
      
      p "------------------------ auth ------------------------"
       p auth
       user = User.find_or_create_by(uid: auth['uid'])
         user.token = auth['credentials']['token']
         user.secret = auth['credentials']['secret']
         user.save
         
         session[:uid] = user.uid
         redirect_to '/home/shake'
       
        # render :text => params
       
  end
  
  # def auth
  #   
  #   render :text => ""
  #   
  # end
  
  def index
    
    render :text => params
    
  end
  
end

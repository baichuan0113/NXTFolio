class LoginInfoController < ApplicationController
  
  #Variable that holds a params/object with all the attributes filled in
  def list
    @login_infos = LoginInfo.all
  end
   
  def show
    @login_info = LoginInfo.find(params[:id])
  end
   
  def new
    @login_info = LoginInfo.new
  end
   
  def create
    @login_info = LoginInfo.new(login_info_params)
    puts @login_info[:email]
    puts @login_info[:password]
    puts login_info_params[:password_confirmation]
    
    if LoginInfo.exists?(:email => @login_info[:email])
      flash[:notice] = "Email already exists."
      redirect_to new_login_info_path and return
    end
    
    if @login_info[:password] != "" && login_info_params[:password_confirmation] != ""
      if @login_info[:password] == login_info_params[:password_confirmation]
        puts "true"
        @login_info.userKey = SecureRandom.hex(10)
        puts @login_info.userKey
        
        if @login_info.save
          session[:current_user_key] = @login_info.userKey 
          puts "saved"
          flash[:notice] = "Account Created!"
          redirect_to new_general_info_path
        else
          puts "Failed Saving"
          flash[:notice] = "Failed Saving!"
          redirect_to new_login_info_path
        end
      else
        flash[:notice] = "Passwords don't match! Please try again."
        redirect_to new_login_info_path
      end
    else
      flash[:notice] = "Enter your password! Please try again."
      redirect_to new_login_info_path
    end
  end
  
  def login_info_params
    #passing into create with these keys.
    params.require(:login_info).permit(:email, :password, :password_confirmation)
  end
   
  def edit
    if LoginInfo.exists?(:userKey => session[:current_user_key])
      @login_info = LoginInfo.find_by(userKey: session[:current_user_key])
    end
  end
   
  def update
    @login_info = LoginInfo.find_by(userKey: session[:current_user_key])
    
    if login_info_params[:password] == login_info_params[:password_confirmation]
      if @login_info.update_attributes(login_info_params)
        redirect_to '/show_profile'
      else
        render :action => 'edit'
      end
    else
      flash[:notice] = "Passwords don't match!"
      render :action => 'edit'
    end
  end
   
  def delete
    LoginInfo.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def login
    @login_info = LoginInfo.new
  end
  
  def login_submit
    @login_info = LoginInfo.new(login_info_param)
    if LoginInfo.exists?(:email => @login_info[:email])
      puts "correct email"
      @login_user = LoginInfo.find_by(email: @login_info[:email])
      if @login_user[:password] == @login_info[:password]
        #login
        session[:current_user_key] = @login_user[:userKey] 
        flash[:notice] = "Logged In!"
        redirect_to root_path
      else
        flash[:notice] = "Incorrect Password"
      end
    else
      flash[:notice] = "Incorrect Email"
      redirect_to login_info_login_path
    end
  end
  
  def login_info_param
     params.require(:login_info).permit(:email, :password)
  end
  
  def logout
    session[:current_user_key] = nil
    flash[:notice] = "Logged Out!"
    redirect_to root_path
  end
end
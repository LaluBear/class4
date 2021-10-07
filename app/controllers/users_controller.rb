class UsersController < ApplicationController
  before_action :set_user, only: %i[ show show2 edit update destroy]
  before_action :check_if_logged_in, only: %i[ show2 edit update destroy]
  
  # GET /users or /users.json
  def index
    @users = User.all
  end
  
  def newindex
    @users = User.all
  end
  
  # GET /users/1 or /users/1.json
  def show
    @posts = @user.posts;
  end

  # GET /user/1
  def show2
    @posts = @user.posts;
  end


  # GET /users/new
  def new
    @user = User.new
  end
  
  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: "User was successfully created." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "User was successfully updated." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "User was successfully destroyed." }
      format.json { head :no_content }
    end
    
  end
  
  def createnew
    name = params[:name]
    email = params[:email]
    @user = User.create(name: name, email: email)
  end
  
  def login
    @user = User.new
    session[:user_id] = nil 
  end
  
  def attempt_login
    @user = User.find_by(email: params[:user][:email])
    puts params[:user][:email]
    if(@user && @user.authenticate(params[:user][:password]))
    	redirect_to "/user/#{@user.id}", notice: "User was successfully logged in."
    	session[:user_id] = @user.id 
    else
    	redirect_to "/main", status: :unprocessable_entity
    	
    end
    
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:post_id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:email, :name, :birthday, :address, :postal_code, :password)
    end
    
    def logged_in
      if(session[:user_id]==@user.id)
        return true
      else
        redirect_to main_path , notice: "Please log in" 
        return false
      end
    end
    def check_if_logged_in
      if(!logged_in)
        return
      end
    end
end

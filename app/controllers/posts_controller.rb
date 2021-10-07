class PostsController < ApplicationController
  before_action :set_post, only: %i[ edit update destroy]
  before_action :check_if_logged_in, only: %i[ new edit destroy]
  
  # GET /posts/new
  def new
    @post = Post.new
    puts "id :"
    puts params[:id]
    @post.user_id = params[:id]
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @post = Post.new(post_params)
    if @post.save
      redirect_to "/user/#{@post.user_id}", notice: "Post was successfully created."
    else
      redirect_to "/users/#{@post.user_id}/createpost", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @post.update(post_params)
      redirect_to "/user/#{@post.user_id}", notice: "Post was successfully created."
    else
      redirect_to "/posts/#{@post.id}/edit", status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @post.destroy
    redirect_to "/user/#{@post.user_id}", notice: "Post was successfully destroyed."
    
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:msg,:user_id)
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

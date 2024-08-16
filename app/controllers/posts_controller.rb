class PostsController < ApplicationController
    # Step 3.1.3: Implement Basic Authentication
    before_action :authenticate_user!, only: [:create, :update, :destroy]
    before_action :set_post, only: [:show, :update, :destroy]
  
    # GET /posts
    def index
      @posts = Post.all
      render json: @posts
    end
  
    # GET /posts/:id
    def show
      render json: @post
    end
  
    # POST /posts
    def create
      @post = Post.new(post_params)
      @post.user_id = current_user.id
  
      if @post.save
        render json: @post, status: :created, location: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /posts/:id
    def update
      if @post.update(post_params)
        render json: @post
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end
  
    # DELETE /posts/:id
    def destroy
      @post.destroy
    end
  
    private
      # Step 3.1.3: Authentication method
      def authenticate_user!
        token = request.headers['Authorization']
        if token.present?
          @current_user = User.find_by(auth_token: token)
          render json: { error: 'Unauthorized' }, status: :unauthorized unless @current_user
        else
          render json: { error: 'Token missing' }, status: :unauthorized
        end
      end
  
      def current_user
        @current_user
      end
  
      # Use callbacks to share common setup or constraints between actions.
      def set_post
        @post = Post.find(params[:id])
      end
  
      # Only allow a list of trusted parameters through.
      def post_params
        params.require(:post).permit(:title, :content)
      end
  end
  
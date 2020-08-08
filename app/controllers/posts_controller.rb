class PostsController < ApplicationController
    before_action :checked_log_in
    before_action :set_post, only: [:show, :edit, :update, :destroy]
    before_action :check_post_belongs_to_user, only: [:edit, :update, :destroy]


    def index
        @posts = Post.all.ordered_list
    end

    def new
        @post= Post.new(category_id: params[:category_id])
    end

    def create
        @post= current_user.posts.build(posts_params)
       
        if @post.valid?
            @post.save

            redirect_to post_path(@post)
        else 
            render :new    
        end
    end

    def show
        @post = Post.find(params[:id])

    end

    def edit
        if params[:category_id]
            category = Category.find_by(id: params[:category_id])
            @post = category.posts.find_by(id: params[:id])

            redirect_to category_posts_path(category), alert: "Post not found." if @post.nil?
        else 
            @post = Post.find(params[:id])
        end
    end

    def update
        @post = Post.find(params[:id])

        if @post.update(posts_params)
            redirect_to category_post_path(@post.category, @post)
        else
            render :edit
        end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.delete

        redirect_to user_path(current_user)
    end

    def today
        @posts = Post.todays_post

        render :index
    end


    private

    def posts_params
        params.require(:post).permit(:title, :date, :location, :category_id, :review)
    end

    def set_post
        @post = Post.find_by_id(params[:id])
        if !@post
            flash[:message] = "Post Doesn't Exist"
            redirect_to posts_path 
        end
    end

    
    def check_post_belongs_to_user
        if current_user != @post.user
            flash[:message] = "This post doesn't belong to you!"
            redirect_to posts_path   
        end 
    end

    
end

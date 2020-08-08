class CommentsController < ApplicationController

    def create
        @post = Post.find(params[:comment][:post_id])
        @comment = @post.comments.create(comment_params)
        @comment.user = current_user
        @comment.save

        redirect_to category_post_path(@post.category, @post)
    end

    private

    def comment_params
        params.require(:comment).permit(:content, :post_id)
    end


end

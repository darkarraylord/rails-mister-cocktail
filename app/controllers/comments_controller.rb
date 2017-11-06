class CommentsController < ApplicationController
    def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @comment = Comment.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @comment = @cocktail.comments.new(comment_params)
    has_been_saved = @comment.save

    if has_been_saved
      redirect_to cocktail_path(id: @cocktail.id)
    else
      # raise "Dose could not be saved because #{@dose.errors.full_messages}"
      render :new
    end
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end
end

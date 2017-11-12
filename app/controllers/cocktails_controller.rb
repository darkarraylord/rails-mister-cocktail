class CocktailsController < ApplicationController
  def index
    @cocktails = Cocktail.last(4)
  end

  def search
    @cocktails = Cocktail.all
    if params[:search]
      @cocktails = Cocktail.search(params[:search], order: :name)
    else
      @cocktails = Cocktail.all.order("created_at DESC")
    end
  end

  def show
    @cocktail = Cocktail.find(params[:id])
    @cocktails_similar = Cocktail.all
  end

  def new
    @cocktail =  Cocktail.new
  end
  def create
    @cocktail = Cocktail.new(cocktail_params)
    if @cocktail.save
      redirect_to cocktail_path(@cocktail)
    else
      render :new
    end
  end

  def edit
    @cocktail = Cocktail.find(params[:id])
  end

  def update
    @cocktail = Cocktail.find(params[:id])
    @cocktail.update(cocktail_params)
    redirect_to cocktail_path(@cocktail)
  end

  def destroy
    @cocktail = Cocktail.find(params[:id])
    @cocktail.destroy
    redirect_to :back
  end

  def profile
    @cocktails = Cocktail.all
  end

  private
  def cocktail_params
    params.require(:cocktail).permit(:name, :category, :alcoholic, :glass, :instructions, :difficulty, photos: [])
  end
end

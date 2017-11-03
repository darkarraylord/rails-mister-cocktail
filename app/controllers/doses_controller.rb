class DosesController < ApplicationController
  def new
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = Dose.new
  end

  def create
    @cocktail = Cocktail.find(params[:cocktail_id])
    @dose = @cocktail.doses.new(dose_params)
    has_been_saved = @dose.save

    if has_been_saved
      redirect_to cocktail_path(id: @cocktail.id)
    else
      # raise "Dose could not be saved because #{@dose.errors.full_messages}"
      render :new
    end
  end

  def destroy
    @dose = Dose.find(params[:id])
    cocktail_id = Cocktail.find(@dose.cocktail_id)
    @dose.destroy
    redirect_back(fallback_location: cocktail_path)
    #redirect_to cocktail_path(id: cocktail_id)
  end


  def dose_params
    params.require(:dose).permit(:description, :ingredient_id)
  end
end

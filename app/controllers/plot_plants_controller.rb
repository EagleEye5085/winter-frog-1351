class PlotPlantsController < ApplicationController

  def destroy
    # binding.pry
    PlotPlant.find(params[:id]).destroy
    redirect_to plots_path
  end

  private
  def plot_plants_params
    params.permit(:plot_id, :id)
  end

end

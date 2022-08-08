class PlotPlantsController < ApplicationController

  def destroy
    plot_plant = PlotPlant.where(plot_id: params[:plot_id], plant_id: params[:id])
    redirect_to plots_path
  end

  private
  def plot_plants_params
    params.permit(:plot_id, :id)
  end

end

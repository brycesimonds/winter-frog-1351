class PlantPlotsController < ApplicationController
    def destroy
      plant = Plant.find(params[:plant_id])
      plant_plot = plant.plant_plots.find_by(plot_id: params[:plot_id])
      plant_plot.destroy
      redirect_to '/plots'
    end
end
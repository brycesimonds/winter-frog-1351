class Garden < ApplicationRecord
  has_many :plots
  has_many :plant_plots, through: :plots
  has_many :plants, through: :plant_plots

  def distinct_plants
    plants.select('plants.*')
    .where('days_to_harvest < ?', '100')
    .distinct
  end

  # def distinct_plants
  #   plots.joins(:plants).select('plants.*').where('days_to_harvest < ?', '100').distinct
  # end
  #^This above method was created before creating additional relationships and worked to pass the User Story 3. I did not use it because it was returning 'plots' instead of what I wanted, 'plants'
end
class Garden < ApplicationRecord
  has_many :plots

  def distinct_plants
    plots.joins(:plants).select('plants.*').where('days_to_harvest < ?', '100').distinct
  end
end
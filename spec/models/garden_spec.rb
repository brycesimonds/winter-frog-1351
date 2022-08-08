require 'rails_helper'

RSpec.describe Garden do
  describe 'relationships' do
    it { should have_many(:plots) }
  end

  describe 'instance methods' do
    describe '.distinct_plants' do
      it 'returns unqiue plants for the given garden' do
        garden_1 = Garden.create!(name: 'Fun Garden', organic: true)

        plot_1 = Plot.create!(number: 20, size: 'Large', direction: 'East', garden_id: garden_1.id)
        plot_2 = Plot.create!(number: 30, size: 'Medium', direction: 'West', garden_id: garden_1.id)
        plot_3 = Plot.create!(number: 40, size: 'Small', direction: 'North', garden_id: garden_1.id)
        plot_4 = Plot.create!(number: 50, size: 'Large', direction: 'South', garden_id: garden_1.id)
    
        plant_1 = Plant.create!(name: 'Rose', description: 'Thorny', days_to_harvest: 100)
        plant_2 = Plant.create!(name: 'Tulip', description: 'Yellow', days_to_harvest: 101)
        plant_3 = Plant.create!(name: 'Cactus', description: 'Green', days_to_harvest: 99)
        plant_4 = Plant.create!(name: 'Succulent', description: 'Never needs water sometimes', days_to_harvest: 1)
    
        PlantPlot.create!(plant_id: plant_1.id, plot_id: plot_1.id)
        PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_1.id)
        PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_2.id)
        PlantPlot.create!(plant_id: plant_3.id, plot_id: plot_1.id)
        PlantPlot.create!(plant_id: plant_3.id, plot_id: plot_2.id)
        PlantPlot.create!(plant_id: plant_3.id, plot_id: plot_3.id)
        PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_1.id)
        PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_2.id)
        PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_3.id)
        PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_4.id)
        
        expect(garden_1.distinct_plants).to match_array([plant_3, plant_4])
      end
    end
  end
end

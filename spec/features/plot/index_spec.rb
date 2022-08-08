require 'rails_helper'

RSpec.describe 'Plots index page' do
  it 'has a list of all the plot numbers with the names of the plots plants' do 
    garden_1 = Garden.create!(name: 'Fun Garden', organic: true)

    plot_1 = Plot.create!(number: 20, size: 'Large', direction: 'East', garden_id: garden_1.id)
    plot_2 = Plot.create!(number: 30, size: 'Medium', direction: 'West', garden_id: garden_1.id)
    plot_3 = Plot.create!(number: 40, size: 'Small', direction: 'North', garden_id: garden_1.id)
    plot_4 = Plot.create!(number: 50, size: 'Large', direction: 'South', garden_id: garden_1.id)

    plant_1 = Plant.create!(name: 'Rose', description: 'Thorny', days_to_harvest: 90)
    plant_2 = Plant.create!(name: 'Tulip', description: 'Yellow', days_to_harvest: 80)
    plant_3 = Plant.create!(name: 'Cactus', description: 'Green', days_to_harvest: 70)
    plant_4 = Plant.create!(name: 'Succulent', description: 'Never needs water sometimes', days_to_harvest: 60)

    PlantPlot.create!(plant_id: plant_1.id, plot_id: plot_1.id)
    PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_1.id)
    PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_2.id)
    PlantPlot.create!(plant_id: plant_3.id, plot_id: plot_3.id)
    PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_4.id)

    visit '/plots'
    
    within "#plot-#{plot_1.id}" do 
      expect(page).to have_content("20")
      expect(page).to have_content("Rose")
      expect(page).to have_content("Tulip")
      expect(page).to_not have_content("Succulent")
    end

    within "#plot-#{plot_2.id}" do 
      expect(page).to have_content("30")
      expect(page).to have_content("Tulip")
      expect(page).to_not have_content("Succulent")
    end

    within "#plot-#{plot_3.id}" do 
      expect(page).to have_content("40")
      expect(page).to have_content("Cactus")
      expect(page).to_not have_content("Succulent")
    end

    within "#plot-#{plot_4.id}" do 
      expect(page).to have_content("50")
      expect(page).to have_content("Succulent")
      expect(page).to_not have_content("Rose")
    end
  end

  it 'can delete a plant from a specfic plot' do 
    garden_1 = Garden.create!(name: 'Fun Garden', organic: true)
    garden_2 = Garden.create!(name: 'Lame Garden', organic: false)

    plot_1 = Plot.create!(number: 20, size: 'Large', direction: 'East', garden_id: garden_1.id)
    plot_2 = Plot.create!(number: 30, size: 'Medium', direction: 'West', garden_id: garden_1.id)
    plot_3 = Plot.create!(number: 40, size: 'Small', direction: 'North', garden_id: garden_1.id)
    plot_4 = Plot.create!(number: 50, size: 'Large', direction: 'South', garden_id: garden_1.id)
    plot_5 = Plot.create!(number: 60, size: 'Large', direction: 'NorthEast', garden_id: garden_2.id)

    plant_1 = Plant.create!(name: 'Rose', description: 'Thorny', days_to_harvest: 90)
    plant_2 = Plant.create!(name: 'Tulip', description: 'Yellow', days_to_harvest: 80)
    plant_3 = Plant.create!(name: 'Cactus', description: 'Green', days_to_harvest: 70)
    plant_4 = Plant.create!(name: 'Succulent', description: 'Never needs water sometimes', days_to_harvest: 60)
    plant_5 = Plant.create!(name: 'Bamboo', description: 'Can grow big', days_to_harvest: 50)

    PlantPlot.create!(plant_id: plant_1.id, plot_id: plot_1.id)
    PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_1.id)
    PlantPlot.create!(plant_id: plant_2.id, plot_id: plot_2.id)
    PlantPlot.create!(plant_id: plant_3.id, plot_id: plot_3.id)
    PlantPlot.create!(plant_id: plant_4.id, plot_id: plot_4.id)
    PlantPlot.create!(plant_id: plant_5.id, plot_id: plot_5.id)

    visit '/plots'
   
    within "#plot-#{plot_1.id}" do 
      expect(page).to have_content("Rose")
      expect(page).to have_content("Tulip")
      expect(page).to have_button('Remove from Plot', count: 2)
      click_button('Remove from Plot', match: :first)
    end

    expect(current_path).to eq("/plots")

    within "#plot-#{plot_1.id}" do 
      expect(page).to_not have_content("Rose")
      expect(page).to have_content("Tulip")
      expect(page).to have_button('Remove from Plot', count: 1)
    end
  end
end 
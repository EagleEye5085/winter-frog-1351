require 'rails_helper'

RSpec.describe "plots index" do
  before :each do
    @turing_garden = Garden.create!(name: 'Turing Community Garden', organic: true)
    @library_garden = Garden.create!(name: 'Public Library Garden', organic: true)
    @other_garden = Garden.create!(name: 'Main Street Garden', organic: false)

    @plot_1 = @turing_garden.plots.create!(number: 25, size: "Large", direction: "East")
    @plot_2 = @turing_garden.plots.create!(number: 26, size: "Small", direction: "West")
    @plot_3 = @library_garden.plots.create!(number: 2, size: "Small", direction: "South")
    @plot_4 = @other_garden.plots.create!(number: 738, size: "Medium", direction: "West")

    @plant_1 = Plant.create!(name: 'corn', description: 'Yellow and sweet', days_to_harvest: 45)
    @plant_2 = Plant.create!(name: 'carrot', description: 'Orange and crisp', days_to_harvest: 60)
    @plant_3 = Plant.create!(name: 'pumpkin', description: 'Orange and spooky', days_to_harvest: 50)
    @plant_4 = Plant.create!(name: 'potato', description: 'Brown and savory', days_to_harvest: 35)

    @plot_plants_1 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_1.id)
    @plot_plants_2 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_2.id)
    @plot_plants_3 = PlotPlant.create!(plot_id: @plot_3.id, plant_id: @plant_3.id)
    @plot_plants_4 = PlotPlant.create!(plot_id: @plot_4.id, plant_id: @plant_2.id)
    @plot_plants_5 = PlotPlant.create!(plot_id: @plot_1.id, plant_id: @plant_3.id)
    @plot_plants_6 = PlotPlant.create!(plot_id: @plot_2.id, plant_id: @plant_4.id)

    visit '/plots'
  end

  it 'lists all plot numbers and each plots plants' do
# save_and_open_page
    within "#plot-#{@plot_1.id}" do
      expect(page).to have_content(@plot_1.number)
      expect(page).to have_content(@plant_1.name)
      expect(page).to have_content(@plant_3.name)
      expect(page).to_not have_content(@plant_4.name)
    end

    within "#plot-#{@plot_2.id}" do
      expect(page).to have_content(@plot_2.number)
      expect(page).to have_content(@plant_2.name)
      expect(page).to have_content(@plant_4.name)
      expect(page).to_not have_content(@plant_3.name)
    end
  end

  it 'can remove a plant from a plot' do
    within "#plot-#{@plot_1.id}" do
      expect(page).to have_link("Remove corn")

      click_link "Remove corn"
    end

    expect(current_path).to eq(plots_path)

    within "#plot-#{@plot_1.id}" do
      expect(page).to_not have_content(@plant_1.name)
    end
  end
end
